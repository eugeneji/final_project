package more.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import more.cart.model.cartDAO;
import more.cart.model.showCartDTO;
import more.cart.model.wishDTO;
import more.cate.model.cateDao;
import more.email.model.EmailDAO;
import more.email.model.EmailDTO;
import more.imgupload.UploadImg;
import more.itemandcate.model.itemandcateDTO;
import more.order.model.orderDAO;
import more.order.model.orderDTO;
import more.order.model.reviewOrderDTO;
import more.order.model.userOrderListDTO;
import more.shopitem.model.shopitemDAO;
import more.shopitem.model.shopitemDTO;
import more.shopitem.model.userShopItemDAO;
import more.shopreview.model.itemReviewListDTO;
import more.shopreview.model.shopReviewDAO;
import more.shopreview.model.shopReviewDTO;
import more.user.model.UserDTO;
import more.usershopitem.model.userShopItemDTO;

@Controller
public class shopUserController {
	@Autowired
	private cateDao catedao;
	@Autowired
	private userShopItemDAO ushopdao;
	@Autowired
	private cartDAO cdao;
	@Autowired
	private orderDAO odao;
	@Autowired
	private shopReviewDAO srdao;
	@Autowired
	EmailDAO emailDao;
	
	@RequestMapping("shopMain.do")
	public ModelAndView shopMain() throws Exception {
		
		
		List cate = catedao.loadCategory();
		ModelAndView mav = new ModelAndView();
		mav.addObject("cate",cate);
		mav.setViewName("shop/shoppingMallMain");
		return mav;
	}



	@RequestMapping(value = "/selectShopitem.do" , produces="application/json; charset=utf8")
	@ResponseBody
	public Map selectItemList(
			@RequestBody Map<String, Object> data) throws Exception {

		
		
		int cate_code = Integer.parseInt(String.valueOf(data.get("cate_code"))); 

		//마이바티스 이프문 오류 최소화를 위해 맵으로 보낼지 고민 중
		Map map = new HashMap();
		map.put("cate_code", cate_code);
		List list = ushopdao.selectItemUserView(cate_code);

		Map resultMap = new HashMap();
		resultMap.put("list", list);
		return resultMap;
	}
	
	
	@RequestMapping("/itemDetail.do")
	public ModelAndView itemDetail(
			@RequestParam("item_idx")int item_idx
			,HttpServletRequest  req
			,HttpSession session
			,HttpServletResponse resp
			) throws Exception {
		
		List cate = catedao.loadCategory();
		userShopItemDTO item = ushopdao.selectItemDetail(item_idx);
		ModelAndView mav = new ModelAndView();
		
		String thumsPath = item.getItem_mainimg();
		int post = thumsPath.indexOf("/t");
		thumsPath = thumsPath.substring(0, post);
		String fileDir=req.getRealPath("itemImg\\"+thumsPath);
		System.out.println(thumsPath);
		File f=new File(fileDir); //폴더라는 전재
			File fs[]=f.listFiles();
			List<File> fileNames = new ArrayList<File>();
			for(int i=0;i<fs.length;i++){
				if(fs[i].isFile()) {
					fileNames.add(fs[i]);
				}
				
		}
			
		Integer idxInte = item.getItem_idx();
		String idxStr = idxInte.toString();
		
		System.out.println(idxInte);
		System.out.println(idxStr);
		
		String idx="";
		
		Cookie cks[]=req.getCookies();
		if(cks!=null){
		for(int i=0;i<cks.length;i++){
			System.out.println(cks[i].getName());
			System.out.println(cks[i].getValue());
			if(cks[i].getName().equals("itemIdx")){
				idx=cks[i].getValue();
				System.out.println("세션값:"+idx);
				idx = idx+"/"+idxStr;
				System.out.println("세션값:"+idx);
		
			}else {
				idx=idxStr;
			}
		}
		}
			Cookie cck=new Cookie("itemIdx",idx);
			cck.setMaxAge(60*60*24);
			resp.addCookie(cck);
			
		mav.addObject("jscate", JSONArray.fromObject(cate));
		mav.addObject("cate", cate);
		mav.addObject("item", item);
		mav.addObject("path", thumsPath);
		mav.addObject("thums", fileNames);
		mav.setViewName("shop/shoppingItemDetail");
		return mav;
	}
	
	
	@RequestMapping("/goShopList.do")
	public ModelAndView goShopList(
			@RequestParam(value = "cate_code", defaultValue = "1000")int cate_code
			,@RequestParam(value = "search_option", defaultValue = "")String search_option
			) throws Exception {
		
		List cate = catedao.loadCategory();
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("jscate", JSONArray.fromObject(cate));
		mav.addObject("cate", cate);
		mav.addObject("cate_code", cate_code);
		mav.addObject("search_option", search_option);
		mav.setViewName("shop/shoppingItemList");
		return mav;
	}
	
	@RequestMapping("/shopitemList.do")
	@ResponseBody
	public Map ShopList(
			@RequestParam(value = "cate_code", defaultValue = "1")int cate_code
			,@RequestParam(value = "search_option", defaultValue = "")String search_option
			,@RequestParam(value = "sort_option", defaultValue = "item_idx")String sort_option
			,@RequestParam(value = "cp", defaultValue = "1")int cp
			,HttpServletRequest req
			,HttpSession session
			) throws Exception {
		System.out.println("검색어 : "+search_option);
		System.out.println("카테고리 : "+cate_code);
		System.out.println("정렬조건 : "+sort_option);
		int listSize = 6;
		int start=(cp-1)*listSize+1;
		int end= cp*listSize;
		Map resultMap = new HashMap();
		Map map = new HashMap();
		map.put("cate_code", cate_code);
		map.put("search_option", search_option);
		map.put("sort_option", sort_option);
		map.put("start", start);
		map.put("end", end);
		
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		if(dto!=null) {
			map.put("user_idx", dto.getUser_idx());
		}else {
			map.put("user_idx", 0);
		}
		
		
		List list = ushopdao.itemList(map);
		
		
		
		List<String> strist = null;
		String strs = "";
		String[] cookieValues = null;
		Cookie cks[]=req.getCookies();
		if(cks!=null){
		for(int i=0;i<cks.length;i++){
			if(cks[i].getName().equals("itemIdx")){
				strs=cks[i].getValue();
				System.out.println("세션값:"+strs);
				cookieValues = (strs.split("/"));
				break;
			}
		}
		}
		
		 if(cookieValues != null){
			 strist = new ArrayList<String>(Arrays.asList(cookieValues));
			   
			   if (strist.size() > 3) { // 값이 3개를 초과하면, 최근 것 3개만 담는다.
			    int first = strist.size() - 3;
			    List<String> copyList = new ArrayList<String>();
			    for (int i = first ; i < strist.size() ; i++) {
			     copyList.add(strist.get(i));
			     System.out.println("세션값:"+strist.get(i));
			    }
			    strist = copyList;
			   }
			   List<shopitemDTO> lastList= ushopdao.lastList(strist);   
			   resultMap.put("last", lastList);
			  }
			 
		   
		
		
		resultMap.put("list", list);
		
		return resultMap;
	}
	
	@RequestMapping("/insertCart.do")
	@ResponseBody
	public Map insertCart(HttpServletRequest req, HttpSession session ) {
		
		
		Map resultMap = new HashMap();
		
		if(session.getAttribute("s_user")==null) {
			resultMap.put("msg", "로그인 후 이용 가능합니다.");
			return resultMap;
		}
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		Integer user_idx = dto.getUser_idx();
		Integer cart_unit = Integer.parseInt(req.getParameter("cart_unit"));
		Integer item_idx = Integer.parseInt(req.getParameter("item_idx"));
		
		Map<String, Integer> map=new HashMap<String, Integer>();
		map.put("cart_unit", cart_unit);
		map.put("item_idx", item_idx);
		map.put("user_idx", user_idx);

		int result = cdao.insertCart(map);
		
		String msg = result>0?"장바구니에 담았습니다. 이동하시겠습니까? ":"장바구니에 담지 못했습니다.";
		resultMap.put("msg", msg);
		resultMap.put("result", result);
		return resultMap;
	}
	@RequestMapping("/goCartList.do")
	public ModelAndView goCartList(HttpSession session){
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("s_user")==null) {
			mav.setViewName("redirect:login.do");
			return mav;
		}
		mav.setViewName("shop/shoppingCart");
		return mav;
	}
	
	@RequestMapping("/getCartList.do")
	@ResponseBody
	public Map getCartList(HttpSession session) {
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		Integer user_idx = dto.getUser_idx();
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("user_idx", user_idx);
		
		List<showCartDTO> list = cdao.showCartList(map);
		
		Map resultMap = new HashMap();
		resultMap.put("list", list);
		return resultMap;
	}
	
	@RequestMapping(value = "/delCartList.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map delCartList(@RequestBody HashMap<String, Object> p) {
		
		JSONObject jo= JSONObject.fromObject(p);
		JSONArray itemIdxs = (JSONArray) jo.get("itemIdx");
		System.out.println(p);
		System.out.println(itemIdxs);
		ArrayList<Integer> idxList = new ArrayList<Integer>();
		
		int result = 0;
		
		for(int i=0;i<itemIdxs.size();i++) {
			idxList.add(Integer.valueOf(String.valueOf(itemIdxs.get(i))));
		}
		if(idxList!=null&&idxList.size()>0) {
			result = cdao.deleteCartList(idxList);	
			System.out.println(result);
		}
		String msg = result>0?"삭제되었습니다.":"삭제할 리스트가 없습니다.";
		Map map = new HashMap();
		map.put("msg", msg);
		return map;
	}
	
	@RequestMapping(value = "/updateCartUnit.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map updateCartUnit(@RequestBody Map<String, Integer> param, HttpSession session) {
		
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		Integer user_idx = dto.getUser_idx();
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("item_idx", param.get("item_idx"));
		map.put("update_unit", param.get("update_unit"));
		map.put("user_idx", user_idx);
		
		int result = cdao.updateCartUnit(map);
		
		
		return map;
		
	}
	
	//장바구니 구매시
	@RequestMapping("PaymentForm.do")
	public ModelAndView paymentForm(HttpServletRequest req, HttpSession session) {
		
		String[] carts = req.getParameterValues("putTotal");
		String paymentPrice = req.getParameter("paymentValue");
		ArrayList<Integer> idxList = new ArrayList<Integer>();
		
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		int user_idx = dto.getUser_idx();
		Map map = new HashMap();
		map.put("user_idx", user_idx);
		
		
		if(carts!=null&&carts.length!=0) {
			for(int i = 0 ; i<carts.length;i++) {
				idxList.add(Integer.parseInt(carts[i]));	
			}
			map.put("idxList", idxList);
			
		}
		List list = cdao.showPaymentCarts(map);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.addObject("paymentPrice", paymentPrice);
		mav.setViewName("shop/payment");
		return mav;
	}
	
	@RequestMapping("imPaymentForm.do")
	public ModelAndView impaymentForm(HttpServletRequest req, HttpSession session) {
		
		Integer item_idx = Integer.parseInt(req.getParameter("item_idx"));
		Integer item_unit = Integer.parseInt(req.getParameter("cart_unit"));
		ArrayList<Integer> idxList = new ArrayList<Integer>();
		//상품 dto받아서 넘겨주기 결제화면으로
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		int user_idx = dto.getUser_idx();
		Map map = new HashMap();
		map.put("user_idx", user_idx);
		
		
				idxList.add(item_idx);	
			map.put("idxList", idxList);
			
		List list = cdao.showPaymentCarts(map);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.addObject("item_unit", item_unit);
		mav.setViewName("shop/payment");
		return mav;
	}
	
	@RequestMapping(value = "/a2.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map a2(@RequestBody Map<String, Object> param, HttpSession session) {
	//	JSONObject jo= JSONObject.fromObject(p);
		System.out.println("================================");
		System.out.println(param.get("itemIdx"));
		UserDTO dto2 = (UserDTO) session.getAttribute("s_user");
		UserDTO dto = new UserDTO();
		System.out.println(param.get("user_name")+"//"+param.get("user_email")+"//"+param.get("user_addr_detail"));
		dto.setUser_idx(dto2.getUser_idx());
		dto.setUser_name(String.valueOf(param.get("user_name")));
		dto.setUser_email(String.valueOf(param.get("user_email")));
		dto.setUser_tel(String.valueOf(param.get("user_tel")));
		dto.setUser_addr(String.valueOf(param.get("user_addr")));
		dto.setUser_addr_detail(String.valueOf(param.get("user_addr_detail")));
		System.out.println(dto.getUser_addr()+"["+dto.getUser_name()+"]"+dto.getUser_addr_detail());
		Map map = new HashMap();
		map.put("item_idx", param.get("item_idx"));
		map.put("user", dto);
		return map;
	}
	
	@RequestMapping(value = "/removeCartAndInsetOrder.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map removeCartAndInsetOrder(@RequestBody Map<String, Object> param, HttpSession session) {
		
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		
		orderDTO orderDto = new orderDTO();
		
		orderDto.setUser_name(String.valueOf(param.get("userName")));
		orderDto.setUser_email(String.valueOf(param.get("userID")));
		orderDto.setUser_tel(String.valueOf(param.get("userTel")));
		orderDto.setUser_addr(String.valueOf(param.get("userAddr")));
		orderDto.setUser_addr_detail(String.valueOf(param.get("userAddrDe")));
		orderDto.setUser_totalpay(Integer.valueOf(String.valueOf(param.get("totalPrice"))));
		orderDto.setOrder_state("결제완료");
		
		int order_idx = odao.insertOrderMaster(orderDto);

		
		JSONObject jo= JSONObject.fromObject(param);
		JSONArray carts = (JSONArray) jo.get("cartDTOs");
		ArrayList<showCartDTO> cartDTOs = new ArrayList<showCartDTO>();
		showCartDTO showcartdto=null;
		for(int i = 0; i<carts.size();i++) {
			JSONObject makeDto = (JSONObject) carts.get(i);
			 showcartdto = new showCartDTO();
			 showcartdto.setCart_idx(Integer.valueOf(String.valueOf(makeDto.get("cart_idx"))));
			 showcartdto.setItem_idx(Integer.valueOf(String.valueOf(makeDto.get("item_idx"))));
			 showcartdto.setCart_unit(Integer.valueOf(String.valueOf(makeDto.get("cart_unit"))));
			 cartDTOs.add(showcartdto);
		}
		
		
		EmailDTO emailDto = new EmailDTO();
		emailDto.setSenderName("모어펫");
		emailDto.setSenderMail("kruise1157@gmail.com");
		emailDto.setReceiveMail(orderDto.getUser_email());
		emailDto.setSubject("고객님의 주문이 [결제 완료] 상태로 업데이트 되었습니다.");
		emailDto.setMessage("테스트임당");
		try {
			emailDao.sendMail(emailDto);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		
		Map map = new HashMap();
		map.put("order_idx", order_idx);
		map.put("dtos", cartDTOs);
		int result = odao.insertOrderDetail(map);
		String msg = result>0?"구매완료! 장바구니 삭제 완료":"구매실패";
		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("msg", msg);
		return resultMap;
	}
	
	
	@RequestMapping("/orderList.do")
	public ModelAndView orderList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("s_user")==null) {
			mav.setViewName("redirect:login.do");
			return mav;
		}
		
		mav.setViewName("shop/orderList");
		return mav;
	}
	
	@RequestMapping("/getOrderList.do")
	@ResponseBody
	public Map getOrderList(HttpSession session) {
		System.out.println("4ddasdsa");
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		String user_email = dto.getUser_email();
		System.out.println("email"+user_email);
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", user_email);
		
		List<userOrderListDTO> list = odao.selectOrderList(map);
		
		Map resultMap = new HashMap();
		resultMap.put("list", list);
		return resultMap;
	}
	
	
	
	@RequestMapping("/orderCancel.do")
	@ResponseBody
	public Map orderCancel(@RequestParam("order_idx")int order_idx) {
		
		Map map = new HashMap();
		map.put("order_state", "취소요청");
		map.put("order_idx", order_idx);
		int result = odao.updateOrder(map);
		String msg = result>0?"요청이 처리되었습니다.":"요청 실패! 문제가 반복될 시 고객센터로 연락바람";
		
		Map resultMap = new HashMap();
		resultMap.put("msg", msg);
		return resultMap;
	}
	
	

	@RequestMapping("/selectReview.do")
	@ResponseBody
	public Map selectReview(@RequestParam("order_idx")int order_idx) {
		
		Map map = new HashMap();
		map.put("order_idx", order_idx);
		List<reviewOrderDTO> list = odao.selectOrderItem(map);
		
		Map resultMap = new HashMap();
		resultMap.put("list", list);
		return resultMap;
	}
	
	@RequestMapping("/shopReviewWrite.do")
	@ResponseBody
	public Map shopReviewWrite(MultipartHttpServletRequest req,HttpSession session) {
		UserDTO userdto = (UserDTO) session.getAttribute("s_user");
		int user_idx = userdto.getUser_idx();
		shopReviewDTO dto = new shopReviewDTO();
		int item_idx = Integer.parseInt(req.getParameter("item_idx"));
		int star_score = Integer.parseInt(req.getParameter("star_score"));
		System.out.println(star_score);
		String review_content = req.getParameter("review_content");
		dto.setItem_idx(item_idx);
		dto.setStar_score(star_score);
		dto.setReview_content(review_content);
		dto.setUser_idx(user_idx);
		
		int result = srdao.insertReview(dto);
		String msg = result>0?"생생한 리뷰 감사합니다":" 리뷰작성 실패";
		if(result>0) {
		
		List<MultipartFile> filesuploads = req.getFiles("review_img");
		String uploadPath = req.getRealPath("reviewImg\\");
		String idxDir = UploadImg.makeDir(uploadPath, result);
		String realPath = uploadPath+idxDir;
		UploadImg.uploadSubImg(filesuploads, realPath);
		}
		Map resultMap = new HashMap();
		resultMap.put("msg", msg);
		return resultMap;
	}
	
	@RequestMapping("/getItemReviewList.do")
	@ResponseBody
	public Map getItemReviewList(@RequestParam(value="sort_option",defaultValue = "review_idx desc")String sort_option,@RequestParam("item_idx")int item_idx,@RequestParam(value = "cp", defaultValue = "1")int cp, HttpServletRequest req) {
		int listSize = 1;
		int start=(cp-1)*listSize+1;
		int end= cp*listSize;
		Map map = new HashMap();
		map.put("item_idx", item_idx);
		map.put("start", start);
		map.put("end", end);
		map.put("sort_option", sort_option);
		Map resultMap = new HashMap();
		List<itemReviewListDTO> reviewList = srdao.itemReviewList(map);
		System.out.println(cp+"//"+sort_option+"//");
		String fileDir= null;
		File f =null;
		File fs[] =null;
		for(int i =0;i<reviewList.size();i++) {
			
			fileDir = req.getRealPath("reviewImg\\"+reviewList.get(i).getReview_idx());
			f=new File(fileDir); //폴더라는 전재
			if(f.exists()) {
				fs=f.listFiles();
				String imgs = "";
				for(int j=0;j<fs.length;j++){
					System.out.println(fs[j].isFile());
					if(fs[j].isFile()) {
						if(j==fs.length-1) {
							imgs += fs[j].getName();
						}else {
						imgs += fs[j].getName()+",";
						}
					}
					System.out.println(fs[j].getName());
				}
				reviewList.get(i).setImgs(imgs);
				System.out.println(imgs);
			}
		}
		
		resultMap.put("reviewList", reviewList);
		return resultMap;
	}
	
	
	@RequestMapping("/insertWish.do")
	@ResponseBody
	public Map insertWish(HttpServletRequest req,HttpSession session) {
		Map map = new HashMap();
		String msg=null;
		if(session.getAttribute("s_user")==null) {
			msg = "로그인을 하시면 더욱 다양한 서비스를 이용할 수 있습니다.";
			map.put("msg", msg);
			return map;
		}
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		int user_idx = dto.getUser_idx();
		Integer item_idx = Integer.parseInt(req.getParameter("item_idx"));
		map.put("user_idx", user_idx);
		map.put("item_idx", item_idx);
		
		int result = ushopdao.insertWish(map);
		
		msg = result>0?"찜하기 성공":"문제가 발생했습니다.";
		return map;
	}
	
	@RequestMapping("/insertWishInDetail.do")
	@ResponseBody
	public Map insertWishInDetail(HttpServletRequest req,HttpSession session) {
		Map map = new HashMap();
		String msg=null;
		if(session.getAttribute("s_user")==null) {
			msg = "로그인을 하시면 더욱 다양한 서비스를 이용할 수 있습니다.";
			map.put("msg", msg);
			return map;
		}
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		int user_idx = dto.getUser_idx();
		Integer item_idx = Integer.parseInt(req.getParameter("item_idx"));
		map.put("user_idx", user_idx);
		map.put("item_idx", item_idx);
		
		boolean result = ushopdao.insertWishInDetail(map);
		if(result) {
		
		msg = "이미 위시 리스트에 있는 상품입니다. \r 위시 목록으로 이동하시겠습니까?";	
		
		}else {
		
		int tf = ushopdao.insertWish(map);
		msg = tf>0?"위시 리스트에 추가하셨습니다. \r 위시 목록으로 이동하시겠습니까?":"문제가 발생했습니다.";
		
		}
		
		map.put("msg", msg);
		return map;
	}
	
	
	

	@RequestMapping("/deleteWish.do")
	@ResponseBody
	public Map deleteWish(HttpServletRequest req,HttpSession session) {
		Map map = new HashMap();
		String msg=null;
		if(session.getAttribute("s_user")==null) {
			msg = "로그인을 하시면 더욱 다양한 서비스를 이용할 수 있습니다.";
			map.put("msg", msg);
			return map;
		}
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		int user_idx = dto.getUser_idx();
		Integer item_idx = Integer.parseInt(req.getParameter("item_idx"));
		map.put("user_idx", user_idx);
		map.put("item_idx", item_idx);
		
		int result = ushopdao.deleteWish(map);
		
		msg = result>0?"찜하기 성공":"문제가 발생했습니다.";
		return map;
	}
	@RequestMapping("/lastCookie.do")
	@ResponseBody
	public Map lastCookie(HttpServletRequest req) {
		
		Map resultMap = new HashMap();
		List<String> strist = null;
		String strs = "";
		String[] cookieValues = null;
		Cookie cks[]=req.getCookies();
		if(cks!=null){
		for(int i=0;i<cks.length;i++){
			if(cks[i].getName().equals("itemIdx")){
				strs=cks[i].getValue();
				System.out.println("세션값:"+strs);
				cookieValues = (strs.split("/"));
				break;
			}
		}
		}
		
		 if(cookieValues != null){
			 strist = new ArrayList<String>(Arrays.asList(cookieValues));
			   
			   if (strist.size() > 3) { // 값이 3개를 초과하면, 최근 것 3개만 담는다.
			    int first = strist.size() - 3;
			    List<String> copyList = new ArrayList<String>();
			    for (int i = first ; i < strist.size() ; i++) {
			     copyList.add(strist.get(i));
			     System.out.println("세션값:"+strist.get(i));
			    }
			    strist = copyList;
			   }
			   List<shopitemDTO> lastList= ushopdao.lastList(strist);   
			   resultMap.put("last", lastList);
			  }
	return resultMap;	
	}
	@RequestMapping("/goWishList.do")
	public ModelAndView goWishList(HttpSession session){
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("s_user")==null) {
			mav.setViewName("redirect:login.do");
			return mav;
		}
		mav.setViewName("shop/wishList");
		return mav;
	}
	
	
	
	@RequestMapping("/getWishList.do")
	@ResponseBody
	public Map getgetWishList(HttpSession session, @RequestParam(value="cp", defaultValue = "1")int cp) {
		
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		int listSize =3;
		int start=(cp-1)*listSize+1;
		int end= cp*listSize;
		System.out.println("cp:"+cp);
		Map map = new HashMap();
		map.put("user_idx", dto.getUser_idx());
		System.out.println(map.get("user_idx"));
		map.put("start", start);
		map.put("end", end);
		Map resultMap = new HashMap();
		List<wishDTO> wishList = ushopdao.selectWishList(map);
		resultMap.put("wishList", wishList);
		return resultMap;
	}
	
}
