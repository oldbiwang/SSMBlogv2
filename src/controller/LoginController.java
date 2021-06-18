package controller;

import javax.security.sasl.SaslException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

  @RequestMapping(value = "/validatellogin")
  public String validatelogin(
      @RequestParam(value = "username", required = false) String username,
      @RequestParam(value = "password", required = false) String password,
      HttpServletRequest request,
      HttpServletResponse response)
      throws SaslException {
    if (request.getSession().getAttribute("username") != null) {
      return "admin/backadmin";
    }
    if (service.validate(username, password)) {
      HttpSession session = request.getSession();
      session.setAttribute("username", username);
      return "admin/backadmin";
    }
    return "admin/loginfail";
  }

  // 退出登陆
  @RequestMapping("logout")
  public String logout(HttpServletRequest request, HttpServletResponse response) {
    request.getSession().removeAttribute("username");
    return "redirect:/login";
  }
}
