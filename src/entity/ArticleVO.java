package entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class ArticleVO {

  private Integer id;

  private String title;

  private String titleIntro;

  /** 格式化从前端接收到的时间数据 */
  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date createdTime;

  private String categoryName;

  private String editorMarkdown;

  private String editorHtml;

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getTitleIntro() {
    return titleIntro;
  }

  public void setTitleIntro(String titleIntro) {
    this.titleIntro = titleIntro;
  }

  public Date getCreatedTime() {
    return createdTime;
  }

  public void setCreatedTime(Date createdTime) {
    this.createdTime = createdTime;
  }

  public String getCategoryName() {
    return categoryName;
  }

  public void setCategoryName(String categoryName) {
    this.categoryName = categoryName;
  }

  public String getEditorMarkdown() {
    return editorMarkdown;
  }

  public void setEditorMarkdown(String editorMarkdown) {
    this.editorMarkdown = editorMarkdown;
  }

  public String getEditorHtml() {
    return editorHtml;
  }

  public void setEditorHtml(String editorHtml) {
    this.editorHtml = editorHtml;
  }

  @Override
  public String toString() {
    return "ArticleVO{"
        + "id="
        + id
        + ", title='"
        + title
        + '\''
        + ", titleIntro='"
        + titleIntro
        + '\''
        + ", createdTime="
        + createdTime
        + ", categoryName='"
        + categoryName
        + '\''
        + ", editorMarkdown='"
        + editorMarkdown
        + '\''
        + ", editorHtml='"
        + editorHtml
        + '\''
        + '}';
  }
}
