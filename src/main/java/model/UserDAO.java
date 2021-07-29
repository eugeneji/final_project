package more.user.model;
import java.util.*;

import javax.servlet.http.HttpServletResponse;


public interface UserDAO {

	public int userJoin(UserDTO dto);
	public boolean loginCheck(String user_email,String user_pwd);
	public boolean idCheck(String user_email);
	public UserDTO getUserInfo(String user_email);
	public String findId(UserDTO dto);
	public int findPwd(String user_email);
	public int pwdUpdate(UserDTO dto);
	public UserDTO userConfirm(int user_idx);
	public UserDTO userInfo(int user_idx);
	public int userEdit(UserDTO dto);
}
