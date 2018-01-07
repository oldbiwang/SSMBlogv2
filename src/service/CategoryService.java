package service;

import java.util.List;

import mapping.BlogMapper;
import mapping.CategoryMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.Blog;
import entity.BlogExample;
import entity.Category;

@Service
public class CategoryService {
	@Autowired
	private CategoryMapper categoryMapper; 
	@Autowired
	private BlogMapper blogMapper;
	
	public List<Category> getCategory() {
		return categoryMapper.selectByExample(null);
	}

	public void newtag(String name, String level) {
		Category category = new Category();
		category.setName(name);
		if(level == null)
			level = "1";
		category.setLevel(Integer.parseInt(level));
		categoryMapper.insertSelective(category);
	}

	public void deltag(int id) {
		BlogExample example = new BlogExample();
		example.createCriteria().andCategoryidEqualTo(id);
		blogMapper.deleteByExample(example);
		categoryMapper.deleteByPrimaryKey(id);
	}

	public List<Blog> getTagArticles(int id) {
		BlogExample example = new BlogExample();
		example.createCriteria().andCategoryidEqualTo(id);
		return blogMapper.selectByExample(example);
	}
}
