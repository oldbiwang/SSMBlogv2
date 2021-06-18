package controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import entity.Blog;
import entity.Category;
import entity.Msg;
import service.ArticleService;
import utils.DateUtil;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;

	// 返回文章列表，进行 分页
	@RequestMapping("/articles")
	@ResponseBody
	public Msg getArticlesList(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn) throws ParseException {
		PageHelper.startPage(pn, 5);
		List<Blog> articles = articleService.getAll();

		PageInfo<Blog> pageInfo = new PageInfo<>(articles, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	// 获取分类信息
	@RequestMapping(value="getCategoryName", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public Msg getCategoryName() {
		Msg msg = new Msg();
		List<Category> list = articleService.getCategoryName();
		Map<String, Object> map = new HashMap<>();
		map.put("category", list);
		
		msg.setCode(200);
		msg.setMsg("返回分类名字！");
		msg.setExtend(map);
		return msg;		
	}
	
	// 后台新建博客文章,判断是否登陆，我用  ajax 请求无法跳转页面，
	// 使用了window.location='${APP_PATH }/islogin'; 请求跳转
	@RequestMapping(value="/islogin")
	public String newarticle(HttpServletRequest request, HttpServletResponse response) throws IOException {
		if(request.getSession().getAttribute("username") != null) {
			System.out.println("username = " + request.getSession().getAttribute("username"));
			return "redirect:/newarticle";
		}
		return "admin/error";
	}
	
	// 新建文章
	@RequestMapping(value="/newarticle")
	public String editarticle(HttpServletRequest request, HttpServletResponse response) 
	{
		//得到 session 的值，判断是否已经登陆
		if(request.getSession().getAttribute("username") != null) {
			String username = request.getSession().getAttribute("username").toString();
			if(username != null) {
				return "admin/newblog";
			}
		}
		return "admin/error";
	}

	// 保存 md 和 HTML 到数据库
	@RequestMapping(value = "saveArticle", method = RequestMethod.POST)
	public ModelAndView saveArticle(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "test-editormd-markdown-doc", required = false) String edmdDoc,
			@RequestParam(value = "editorhtml", required = false) String edmdHtml) {
		ModelAndView view = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();

		// 获取文章对应的 分类Id
		Integer categoryId = articleService.getCategoryId(request
				.getParameter("categoryName"));

		Blog blog = new Blog();
		blog.setCategoryid(categoryId);
		blog.setContent(edmdHtml);
		blog.setMd(edmdDoc);
		blog.setTitle(request.getParameter("title"));
		blog.setTitleintro(request.getParameter("titleIntro"));
		String dateStr = request.getParameter("createdtime").replace('/', '-');
		Date date = DateUtil.fomatDate(dateStr);
		blog.setCreatedtime(date);

		articleService.save(blog);
		// 获得文章的标题，标题介绍，日期，分类等信息
		map.put("message", "新建文章成功！");
		view.setViewName("admin/newsuccess");
		view.addObject("map", map);
		return view;
	}
	
	// 编辑文章
	@RequestMapping("/edit")
	public String edit(@RequestParam(value="id", required=true, defaultValue="1") int id, 
			HttpServletRequest request, HttpServletResponse response, Model model) {
		if(request.getSession().getAttribute("username")  != null) {
			model.addAttribute("blogid", id);
			return "admin/edit";
		}	
		return "admin/error";
	}
	
	// 保存修改文章
	@RequestMapping(value="/updatearticle", method=RequestMethod.POST)
	public ModelAndView updatearticle(HttpServletRequest request, HttpServletResponse response,@RequestParam(value = "test-editormd-markdown-doc", required = false) String edmdDoc,
			@RequestParam(value = "editorhtml", required = false) String edmdHtml) {
		ModelAndView view = new ModelAndView();
		String dateStr;
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 获取隐藏域文章的 id
		int id = Integer.parseInt(request.getParameter("id"));
		// 获取文章对应的 分类Id
		Integer categoryId = articleService.getCategoryId(request
				.getParameter("categoryName"));

		Blog blog = new Blog();
		blog.setId(id);
		blog.setCategoryid(categoryId);
		blog.setContent(edmdHtml);
		blog.setMd(edmdDoc);
		blog.setTitle(request.getParameter("title"));
		blog.setTitleintro(request.getParameter("titleIntro"));
		if(request.getParameter("createdtime") != null)
		{
			dateStr = request.getParameter("createdtime").replace('/', '-');
		} else {
			dateStr = new String("1996-2-10");
		}
		Date date = DateUtil.fomatDate(dateStr);
		blog.setCreatedtime(date);

		articleService.update(blog);
		// 获得文章的标题，标题介绍，日期，分类等信息
		map.put("message", "修改文章成功！");
		view.setViewName("admin/editsuccess");
		view.addObject("map", map);
		return view;
	}
	
	
	//通过 id 查找文章并返回
	@RequestMapping("/getarticlebyid")
	@ResponseBody
	public Blog getarticlebyid(@RequestParam(value="id", defaultValue="1") int id) {
		Blog blog = articleService.selectBlogById(id);
		return blog;
	}
	
	
	// 显示文章
	@RequestMapping(value="showarticle", method=RequestMethod.GET)
	public String showarticle(@RequestParam(value="id", defaultValue="1")int id, Model model) {
		String mdString = articleService.getArticleMdStr(id);
		model.addAttribute("mdString", mdString);
		model.addAttribute("id", id);
		return "showarticle";
	}
	
	// 侧边栏阅读模式
	@RequestMapping(value="/showarticlecustomcontanier", method=RequestMethod.GET)
	public String showarticlecustomcontainer(HttpServletRequest request, HttpServletResponse response,
			Model model, @RequestParam(value="id", defaultValue="1")int id) {
		String customMd = articleService.getArticleMdStr(id);
		model.addAttribute("customMd", customMd);
		model.addAttribute("id", id);
		return "showarticlecustomcontanier";
	}
	
	// 删除文章
	@RequestMapping(value="/delete", method=RequestMethod.GET) 
	public void delete(@RequestParam(value="id", required=true)int id,HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		if(request.getSession().getAttribute("username") != null) {
			articleService.deleteArticleById(id);
		} else {
			response.sendRedirect("deletenologin");
		}
	}
	
	// 没有登陆的时候，就不能删除文章
	@RequestMapping("/deletenologin")
	public String deletenologin() {
		return "admin/error";
	}
	
	/*	
	// 返回正常模式
	@RequestMapping(value="/backhtml", method=RequestMethod.POST)
	public String backhtml(HttpServletRequest request, HttpServletResponse response,
			Model model, @RequestParam(value="md", required=true)String md) {
		System.out.println("backmd = " + md);
		model.addAttribute("backmd", md);
		return "showarticle";
	}*/
	
	// 返回评论数最多的四篇文章
	@RequestMapping("/postarticle")
	@ResponseBody
	public Msg postarticle() {
		List<Blog> list = articleService.getAll();
		List<Blog> postList = articleService.postarticle(list);
		System.out.println("size = " + postList.size());
		return Msg.success().add("postList", postList);
	}
	
	@RequestMapping("about")
	public String about() {
		return "about";
	}
	
	@RequestMapping("/contact")
	public String contact() {
		return "contact";
	}
}
