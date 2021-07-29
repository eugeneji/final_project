package more.user.model;

import java.util.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserDAOImple implements UserDAO {

	@Autowired
	private SqlSessionTemplate sqlMap;
	@Autowired
	BCryptPasswordEncoder pwdEncoder;
	
	public int userJoin(UserDTO dto) {
		String inputPwd = dto.getUser_pwd();
		String dbPwd = pwdEncoder.encode(inputPwd);
		dto.setUser_pwd(dbPwd);
		
		sqlMap.insert("userJoin", dto);
		
		return dto.getUser_idx();
	}
	
	public boolean loginCheck(String user_email,String user_pwd) {
		System.out.println(user_email);
		String dbpwd=sqlMap.selectOne("loginCheck", user_email);
		System.out.println(dbpwd);
		boolean bothPwd = pwdEncoder.matches(user_pwd, dbpwd);
		
		return bothPwd;
	}
	public UserDTO getUserInfo(String user_email) {
		
		return sqlMap.selectOne("getUserInfo", user_email);
	}
	public boolean idCheck(String user_email) {
		
		String result = sqlMap.selectOne("idCheck", user_email);
		return result==null?false:true;
		
	}
	public void logout(HttpSession session) {

	}
	
	public String findId(UserDTO dto) {
		String user_email = sqlMap.selectOne("findId", dto ); 
		return user_email;
	}

	
	public int findPwd(String user_email) {
		
		int dbid;
		try {
			dbid=sqlMap.selectOne("findPwd", user_email);
		} catch (NullPointerException e) {
			return 0; 
		}
			
		return dbid;
	}
	public int  pwdUpdate(UserDTO dto) {
		String pwd = pwdEncoder.encode(dto.getUser_pwd());
		dto.setUser_pwd(pwd);
		int count=sqlMap.update("pwdUpdate", dto);
		return count;
	}
	public UserDTO userConfirm(int user_idx) {
		UserDTO dto = sqlMap.selectOne("userConfirm", user_idx);
		return dto;
	}
	
	public UserDTO userInfo(int user_idx) {
		UserDTO dto = sqlMap.selectOne("userInfo", user_idx);
		return dto;
	}
	
	public int userEdit(UserDTO dto) {
		int result = sqlMap.update("userEdit", dto);
		return result;
	}
}