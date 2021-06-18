package utils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.io.FileUtils;

public class UploadUtil {
	public static String uploadImg(String filePath, InputStream in) throws IOException {
		//获取tomcat 的根目录（webapps 下的路径），editormd.root 在web.xml 中配置
		String tomcatRootPath = System.getProperty("editormd.root") + "..";
		String resultPath = tomcatRootPath + filePath;
		
		createFile(resultPath);
		File realFile = new File(resultPath);
		FileUtils.copyInputStreamToFile(in, realFile);
		return resultPath;
	}

	/*
	 * 创建文件， 如果文件夹不存在将被创建
	 * */
	public static File createFile(String resultPath) {
		File file = new File(resultPath);
		if(file.exists())
			return null;
		if(resultPath.endsWith(File.separator))
			return null;
		if(!file.getParentFile().exists()) {
			if(!file.getParentFile().mkdirs())
				return null;
		}
		try {
			if(file.createNewFile())
				return file;
			return null;
		} catch(IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
