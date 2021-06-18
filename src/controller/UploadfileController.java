package controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import utils.DateUtil;
import utils.Myutil;
import utils.UploadUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@Controller
public class UploadfileController {
  Logger log = Logger.getLogger(this.getClass());

  @RequestMapping(value = "uploadImg", method = RequestMethod.POST)
  public void uploadImg(
      HttpServletRequest request,
      HttpServletResponse response,
      @RequestParam(value = "editormd-image-file", required = false) MultipartFile file) {
    log.info("upload img");
    try {
      request.setCharacterEncoding("utf-8");
      response.setHeader("Content-Type", "text/html");
      String suffix =
          file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
      String filePath = "/upload/" + DateUtil.getDays() + "/" + Myutil.random(5) + suffix;
      String resultPath = UploadUtil.uploadImg(filePath, file.getInputStream());
      System.out.println("path=" + resultPath);
      response
          .getWriter()
          .write("{\"success\": 1, \"message\":\"上传成功\",\"url\":\"" + filePath + "\"}");
    } catch (Exception e) {
      e.printStackTrace();
      log.error("upload failed ", e);
      try {
        response.getWriter().write("{\"success\": 0, \"message\":\"上传失败\",\"url\":\"" + "\"}");
      } catch (IOException e1) {
        e1.printStackTrace();
      }
    }
  }
}
