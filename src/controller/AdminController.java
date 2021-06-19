package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
    private final HttpSession session;

    @Autowired
    public AdminController(HttpSession session) {
        this.session = session;
    }

    @RequestMapping(value = "/")
    public String index() {
        if (session.getAttribute("username") == null) {
            return "admin/error";
        }
        return "admin/backadmin";
    }

    /**
     * 重定向到/admin/
     *
     * @return
     */
    @RequestMapping(value = "")
    public String toLogin() {
        return "redirect:/admin/";
    }
}
