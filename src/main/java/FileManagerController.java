package more.controller;

import java.io.*;
import java.util.List;

import javax.imageio.stream.FileImageInputStream;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import more.file.model.FileDTO;

@Controller
public class FileManagerController {

	
	/*실제 파일 복사 관련 메서드*/
	public void copyInto(MultipartFile upload,HttpServletRequest req, int meeting_m_idx) {
		
		System.out.println("파일명:"+upload.getOriginalFilename());
		
		try {
			byte[] bytes=upload.getBytes();//복사할 원본
			
			/*window*/
//			File outFile = new File("/Users/geonhoroh/upload/"+upload.getOriginalFilename());//빈종이
			
			/*ios*/
			File path = new File(req.getSession().getServletContext().getRealPath("/img/meeting/")+meeting_m_idx+"/");
			path.mkdirs();
			File outFile = new File(req.getSession().getServletContext().getRealPath("/img/meeting/")+meeting_m_idx+"/"+upload.getOriginalFilename());//빈종이
			FileOutputStream fos = new FileOutputStream(outFile);
			fos.write(bytes);
			fos.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
//	@RequestMapping("/fileUpload4.do")
//	public String fileUploadSubmit4(
//			@RequestParam("writer")String writer,
//			@RequestParam("upload")List<MultipartFile> upload) {
//		System.out.println("올린파일갯수:"+upload.size());
//		for(int i=0; i<upload.size(); i++) {
//			copyInto(writer, upload.get(i));
//		}
//		return "file/fileOK";
//	}
	
	@RequestMapping("/filedown.do")
	public ModelAndView fileDownload(@RequestParam("filename")String filename) {
		
		/*window*/
//		File f = new File("/Users/geonhoroh/upload/"+filename);
		
		/*ios*/
		File f = new File("/Users/geonhoroh/upload/"+filename);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("downloadFile", f);
		mav.setViewName("moreDown");//지금까지는 jsp 파일을 지정햇지만,다운로드는 bean에 접근할 수 있게 빈이름에게 연결해줌.
		return mav;
	}
}
