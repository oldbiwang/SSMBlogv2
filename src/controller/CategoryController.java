package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import service.CategoryService;
import entity.Blog;
import entity.Category;
import entity.Msg;

@Controller
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	
	// tags 返回标签（我把它理解为分类）
	@RequestMapping(value="/getTags",method=RequestMethod.GET) 
	@ResponseBody
	public Msg getTags() {
		List <Category> tags = categoryService.getCategory();
		return Msg.success().add("tags", tags);
	}
	
	
	// 分类的后台管理
	@RequestMapping(value="/tagadmin") 
	public String tagadmin(HttpServletRequest request, HttpServletResponse response) {
		String username = null;
		if(request.getSession().getAttribute("username") != null) {
			username = request.getSession().getAttribute("username").toString();
		}
		
		if(username == null) {
			return "admin/error";
		}
		return "admin/tagadmin";
	}
	
	// 新建分类
	@RequestMapping(value="/newtag", method=RequestMethod.POST)
	public String newtag(@RequestParam(value="name", required=true) String name,
			@RequestParam(value="level", required=true)String level,Model model) {
		categoryService.newtag(name, level);
		model.addAttribute("msg", "新建分类成功！");
		return "admin/newtagsuccess";
	}
	
	// 删除分类
	@RequestMapping(value="deletetag", method=RequestMethod.GET) 
	@ResponseBody
	public Msg deletetag(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="id", required=true)int id) {
		String username = null;
		if(request.getSession().getAttribute("username") != null) {
			username = request.getSession().getAttribute("username").toString();
		}
		if(username == null) {
			return Msg.fail().add("msg", "你没有登陆");
		}
		categoryService.deltag(id);
		return Msg.success().add("msg", "删除分类成功！");
	}
	
	@RequestMapping("tag")
	public String tag(@RequestParam("id")int id, Model model) {
		model.addAttribute("id", id);
		return "tag";
	}
	
	// 返回该分类所有的文章
	@RequestMapping(value="/tagarticle", method=RequestMethod.GET)
	@ResponseBody
	public Msg tagarticle(@RequestParam("id") int id,
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			Model model) {
		PageHelper.startPage(pn, 5);
		List<Blog> list = categoryService.getTagArticles(id);
		PageInfo<Blog> pageInfo = new PageInfo<>(list, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}
}
