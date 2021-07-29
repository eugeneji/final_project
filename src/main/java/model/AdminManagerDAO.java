package more.adminManager.model;

import java.util.*;
import more.adminManager.model.*;

public interface AdminManagerDAO {

	public List userManager(int cp, int ls);
	public int user_getTotalCnt();
	public AdminManagerDTO userView(int user_idx);
	public int userBen(int user_idx);
	public int userBenCancel(int user_idx);
	public int bbsManager();
}
