package controller;

import javax.security.sasl.SaslException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;
import service.LoginService;

@Controller
public class LoginController {
  private final LoginService service;

  @Autowired
  public LoginController(LoginService service) {
    this.service = service;
  }

  @RequestMapping("/login")
  public String login() {
    return "admin/login";
  }

  @RequestMapping(value = "/doLogin", method = RequestMethod.POST)
  @ResponseBody
  public Msg doLogin(
      @RequestParam(value = "username", required = false) String username,
      @RequestParam(value = "password", required = false) String password,
      HttpServletRequest request)
      throws SaslException {

    if (service.validate(username, password)) {
      HttpSession session = request.getSession();
      session.setAttribute("username", username);
      return Msg.success("登录成功!，正在进入后台");
    }
    return Msg.fail("登录失败!");
  }

  // 退出登陆
  @RequestMapping("logout")
  public String logout(HttpServletRequest request, HttpServletResponse response) {
    request.getSession().removeAttribute("username");
    return "redirect:/login";
  }
}
