package com.infopublic.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.runner.Request;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import Decoder.BASE64Decoder;

/**
 * 图片操作
 * @author yxy
 *
 */
public class FileInputread {
	/**
	 * 图片输出
	 * @param response 
	 * @param imgurl 图片路径
	 * @throws IOException
	 * @author yxy
	 */
	public static void Imageshow(HttpServletRequest request,HttpServletResponse response,String imgurl) throws IOException{
		FileInputStream hFile=null;
		try {
			String ImgPath=request.getSession().getServletContext().getRealPath("/");
			ImgPath=ImgPath+Const.FILEPATHIMG;
			ImgPath=ImgPath.replace("\\", "/");
			//System.out.println("输出图片："+ImgPath);
			hFile = new FileInputStream(ImgPath+imgurl);
			int i=hFile.available(); //得到文件大小
			byte[] bs=new byte[i];
			hFile.read(bs);
			response.setContentType("image/*"); //设置返回的文件类型 
			OutputStream toClient=response.getOutputStream(); //得到向客户端输出二进制数据的对象
			toClient.write(bs);
			toClient.flush();  
	        toClient.close(); 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}finally{
			if(hFile!=null)
				hFile.close();
		}
	}
	
	/**
	 * 将上传的图片的字节存入磁盘 
	 * @param imagepath 传入的base64编码
	 * @return 图片存放的总路径
	 * @throws IOException 
	 */
	public static String uploadimgsave(String imagepath,HttpServletRequest request) throws IOException{
		OutputStream os=null;
		String ImgPath=request.getSession().getServletContext().getRealPath("/");
		ImgPath=ImgPath+Const.FILEPATHIMG;
		//System.out.println(ImgPath);
		String newimagepath="";
		String[] ss=imagepath.split("/");
		String[] ss1=ss[1].split(";");  //获得图片格式
		//System.out.println(ss1[0]);
		switch (ss1[0]) {
		case "jpeg":
			ss1[0]=".jpg";
			newimagepath=imagepath.replaceAll("data:image/jpeg;base64,", ""); //替换
			break;
		case "png":
			ss1[0]=".png";
			newimagepath=imagepath.replaceAll("data:image/png;base64,", ""); //替换
			break;
		case "jpg":
			ss1[0]=".jpg";
			newimagepath=imagepath.replaceAll("data:image/jpg;base64,", ""); //替换
			break;
		default://若前端没有限制格式 可再加
			break;
		}
		String uuid=UUID.randomUUID().toString();
		String url=uuid+ss1[0];  //图片名称：uuid+图片格式
		FileUpload.mkdirsmy(ImgPath,url); //路径是否存在，不存在则创建
		BASE64Decoder decoder = new BASE64Decoder();  //对base64编码解码
		try {
			byte[] b=decoder.decodeBuffer(newimagepath);
			os=new FileOutputStream(ImgPath+url);  //图片上传保存路径
			os.write(b);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
				try {
					if(os!=null)
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
		String uploadpathRed=request.getSession().getServletContext().getRealPath("/");
		uploadpathRed=uploadpathRed+Const.FILEPATHIMGRED;
			//System.out.println("全部路径"+uploadpathRed);
		
		FileUpload.mkdirsmy(uploadpathRed,url); //路径是否存在，不存在则创建
		reduceImg(ImgPath+url, uploadpathRed+url, 1000, 1000,(float) 0.3);  //按1/3比例压缩
		return url;	
	}
	
	
	/** 
     * 采用指定宽度、高度或压缩比例 的方式对图片进行压缩 
     * @param imgsrc 源图片地址 
     * @param imgdist 目标图片地址 
     * @param widthdist 压缩后图片宽度（当rate==null时，必传） 
     * @param heightdist 压缩后图片高度（当rate==null时，必传） 
     * @param rate 压缩比例  
     */  
    public static void reduceImg(String imgsrc, String imgdist, int widthdist,  
            int heightdist, Float rate) {  
        try {  
            File srcfile = new File(imgsrc);  
            // 检查文件是否存在  
            if (!srcfile.exists()) {  
                return;  
            }  
            // 如果rate不为空说明是按比例压缩  
            if (rate != null && rate > 0) {  
                // 获取文件高度和宽度  
                int[] results = getImgWidth(srcfile);  
                if (results == null || results[0] == 0 || results[1] == 0) {  
                    return;  
                } else {  
                    widthdist = (int) (results[0] * rate);  
                    heightdist = (int) (results[1] * rate);  
                }  
            }  
            // 开始读取文件并进行压缩  
            Image src = javax.imageio.ImageIO.read(srcfile);  
            BufferedImage tag = new BufferedImage((int) widthdist,  
                    (int) heightdist, BufferedImage.TYPE_INT_RGB);  
  
            tag.getGraphics().drawImage(  
                    src.getScaledInstance(widthdist, heightdist,  
                            Image.SCALE_SMOOTH), 0, 0, null);  
  
            FileOutputStream out = new FileOutputStream(imgdist);  
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);  
            encoder.encode(tag);  
            out.close();  
  
        } catch (IOException ex) {  
            ex.printStackTrace();  
        }  
    }
    
    
    /** 
     * 获取图片宽度 
     *  
     * @param file 
     *            图片文件 
     * @return 宽度 
     */  
    public static int[] getImgWidth(File file) {  
        InputStream is = null;  
        BufferedImage src = null;  
        int result[] = { 0, 0 };  
        try {  
            is = new FileInputStream(file);  
            src = javax.imageio.ImageIO.read(is);  
            result[0] = src.getWidth(null); // 得到源图宽  
            result[1] = src.getHeight(null); // 得到源图高  
            is.close();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return result;  
    }
	
	/**
	 * 得到空格分隔的路径
	 * @param url
	 * @return
	 */
	public static List<String> getURL(String url){
		List<String> li=new ArrayList<String>();
		if(!"".equals(url) && url!=null){
		String[] s=url.split(" ");
		for (int i = 0; i < s.length; i++) {
			li.add(s[i]);
		}
		}
		return li;	
	}

}
