package controller;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import entity.Comment;
import entity.Msg;
import service.CommentService;

@Controller
public class CommentController {
  private final CommentService commentService;

  private final HttpSession session;

  @Autowired
  public CommentController(CommentService commentService, HttpSession session) {
    this.commentService = commentService;
    this.session = session;
  }

  // 提交评论
  @RequestMapping(value = "/sendcomment", method = RequestMethod.POST)
  @ResponseBody
  public Msg sendcomment(
      @RequestParam(value = "id", required = true) int id,
      @RequestParam("name") String name,
      @RequestParam("comment") String comment)
      throws ParseException {
    commentService.sendcomment(id, name, comment);
    Msg msg = Msg.success();
    msg.setMsg("提交评论成功！");
    return msg;
  }

  // 获得评论
  @RequestMapping(value = "/getComments", method = RequestMethod.GET)
  @ResponseBody
  public Msg getComments(@RequestParam("id") int id) {
    // 获取文章所有的评论
    List<Comment> list = commentService.getComments(id);
    return Msg.success().add("commentsList", list);
  }

  // 获得所有评论
  @RequestMapping(value = "/getallcomments", method = RequestMethod.GET)
  @ResponseBody
  public Msg getallcomments() {
    List<Comment> list = commentService.selectAll();
    return Msg.success().add("commentList", list);
  }

  // 评论后台管理
  @RequestMapping("/commentback")
  public String commentback() {
    // 得到 session 的值，判断是否已经登陆
    if (session.getAttribute("username") != null) {
      String username = session.getAttribute("username").toString();
      if (username != null) {
        return "admin/commentadmin";
      }
    }
    return "admin/error";
  }

  // 删除一条评论
  @RequestMapping(value = "/deleteacomment", method = RequestMethod.GET)
  @ResponseBody
  public Msg deleteacomment(@RequestParam("id") int id) {
    commentService.deletea(id);
    Msg msg = Msg.success();
    msg.setMsg("此条评论已删除！");
    return msg;
  }

  // 提交评论
  @RequestMapping(value = "/sendheartword", method = RequestMethod.POST)
  @ResponseBody
  public Msg sendheartword(
      @RequestParam(value = "id", required = true) int id,
      @RequestParam("name") String name,
      @RequestParam("comment") String comment)
      throws ParseException {
    System.out.println("name = " + name + " \ncomment = " + comment);
    commentService.sendcomment(id, name, comment);
    Msg msg = Msg.success();
    msg.setMsg("我收到你的心声了！");
    return msg;
  }
}
