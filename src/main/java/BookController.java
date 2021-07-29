package more.controller;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import more.sitter.model.*;
import more.user.model.UserDTO;
import more.book.model.*;
import more.pet.model.*;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@EnableWebMvc
public class BookController {

	@Autowired
	private SitterDAO sitterDao;
	@Autowired
	private BookDAO bookDao;
	@Autowired
	private PetDAO petDao;
	
	@RequestMapping("bookMain.do")
	public ModelAndView bookMain() {
		ModelAndView mav = new ModelAndView();
		List sitterList = sitterDao.sitterList();
		mav.addObject("sitterList",sitterList);
		mav.setViewName("petsitter/book/main");
		return mav;
	}
	
	@RequestMapping("book.do")
	public ModelAndView bookDetail(int idx, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("sitter",sitterDao.sitterProfile(idx));
		mav.addObject("petList",petDao.pet_list(((UserDTO)session.getAttribute("s_user")).getUser_idx()));
		mav.setViewName("petsitter/book/detail");
	
		return mav;
	}
	
	@RequestMapping("bookApply.do")
	@ResponseBody
	public Map bookDo(BookDTO dto) {	
		
		bookDao.bookApply(dto);
		Map<String,String> map = new HashMap<String, String>();
		String alarm = "<a href='bookSitterList.do?'>예약 신청 도착</a>";
		map.put("message", alarm);
		return map;
	}
	
	@RequestMapping("bookList.do")
	public ModelAndView bookList(@RequestParam(value = "cp", defaultValue = "1")int cp, HttpSession session) {
		
		int user_idx= ((UserDTO)session.getAttribute("s_user")).getUser_idx();
		int list = 10;
		Map map = new HashMap<String, Integer>();
		map.put("start", (cp-1)*list+1);
		map.put("end", cp*list);
		map.put("user_idx", user_idx);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("bookList", bookDao.bookList(map));
		mav.setViewName("petsitter/book/list");
		return mav;
	}
	
	@RequestMapping("bookSitterList.do")
	public ModelAndView bookSitterList(@RequestParam(value = "cp", defaultValue = "1")int cp, HttpSession session) {
		
		int user_idx= ((UserDTO)session.getAttribute("s_user")).getUser_idx();
		int list = 10;
		Map map = new HashMap<String, Integer>();
		map.put("start", (cp-1)*list+1);
		map.put("end", cp*list);
		map.put("user_idx", user_idx);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("bookList", bookDao.bookSitterList(map));
		mav.setViewName("petsitter/book/apply");
		return mav;
	}
	
	@RequestMapping("showDetail.do")
	@ResponseBody
	public Map showDetail(int book_idx) {
		
		Map<String, BookDTO> map = new HashMap<String, BookDTO>();
		map.put("book", bookDao.showDetail(book_idx));
		
		return map;
	}
	
	@RequestMapping("cardSave.do")
	@ResponseBody
	public void cardSave(HttpSession session) {
		int user_idx= ((UserDTO)session.getAttribute("s_user")).getUser_idx();
		bookDao.cardSave(user_idx);
	}
	
	@RequestMapping("bookDetail.do")
	@ResponseBody
	public Map bookDetail2(int book_idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("book", bookDao.showDetail(book_idx));
		String pet_idx = ((BookDTO)map.get("book")).getPet_idx();
		String pet[] = pet_idx.split(",");
		List<PetDTO> list = new ArrayList<PetDTO>();
		for(int i=0;i<pet.length;i++) {
			list.add(petDao.pet_info(pet[i]));
			
		}

		map.put("pet", list);
		return map;
	}
	
	@RequestMapping("bookUpdate.do")
	@ResponseBody
	public void bookUpdate(BookDTO dto) {
		bookDao.bookUpdate(dto);
	}
	
	
	@RequestMapping("payment.do")
	@ResponseBody
	public String payment(HttpServletRequest req, HttpServletResponse resp, String user_idx, String book_idx, String price) {
		
		try {
			Map map = new HashMap<String, String>();
			String _token ="";
			
			String imp_key = URLEncoder.encode("1982068988566111", "UTF-8");
			String imp_secret =	URLEncoder.encode("3AfeYvX8uOqxtjtj92ZMd6WQ5dUQ44Y7EdmDIkLd8cKCveVEgUru1ok6BfWGjVNY99BSun5CzQe44aJl", "UTF-8");
			
			JSONObject json = new JSONObject();
			json.put("imp_key", imp_key);
			json.put("imp_secret", imp_secret);
			_token = getToken(req, resp, json, "https://api.iamport.kr/users/getToken");
			
			json = new JSONObject();
			json.put("customer_uid", user_idx);
			json.put("merchant_uid", book_idx);
			json.put("amount", price);
			
			return payment(req,resp, json, "https://api.iamport.kr/subscribe/payments/again",_token);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;	
		}
	}
	
	public String getToken(HttpServletRequest request, HttpServletResponse response, JSONObject json, String requestURL) throws Exception{
		try{
			String _token = "";	
			String requestString = "";
			URL url = new URL(requestURL);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true); 				
			connection.setInstanceFollowRedirects(false);  
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-Type", "application/json");
			OutputStream os= connection.getOutputStream();
			os.write(json.toString().getBytes());
			connection.connect();
			
			StringBuilder sb = new StringBuilder(); 
			if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
				
				String line = null;  
				while ((line = br.readLine()) != null) {  
					sb.append(line + "\n");  
				}
				br.close();
				requestString = sb.toString();
			}
			os.flush();
			connection.disconnect();
			
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
			
			if((Long)jsonObj.get("code")  == 0){
				JSONObject getToken = (JSONObject) jsonObj.get("response");
				System.out.println("getToken==>>"+getToken.get("access_token") );
				_token = (String)getToken.get("access_token");
			}
			return _token;
			
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	public String payment(HttpServletRequest request, HttpServletResponse response, JSONObject json, String requestURL,String token) throws Exception{

		// requestURL 아임포트 고유키, 시크릿 키 정보를 포함하는 url 정보 

		String _token = "";

		try{
			String requestString = "";
			URL url = new URL(requestURL);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true); 				
			connection.setInstanceFollowRedirects(false);  
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-Type", "application/json");
			connection.setRequestProperty("Authorization", token);
			OutputStream os= connection.getOutputStream();
			os.write(json.toString().getBytes());
			connection.connect();
			StringBuilder sb = new StringBuilder(); 

			if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {

				BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
				String line = null;  

				while ((line = br.readLine()) != null) {  

					sb.append(line + "\n");  
				}

				br.close();
				requestString = sb.toString();

			}

			os.flush();
			connection.disconnect();
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
			if((Long)jsonObj.get("code")  == 0){

				JSONObject getToken = (JSONObject) jsonObj.get("response");
				System.out.println("getToken==>>"+getToken.get("status") );
				_token = (String)getToken.get("status");

			}
		}catch(Exception e){
			e.printStackTrace();
			_token = "";
		}
		return _token;
	}

}
