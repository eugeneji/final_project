package more.pet.model;

import java.util.List;
import java.util.Map;

public interface PetDAO {
	
	public int pet_register(PetDTO dto, int user_idx);
	public List<Map<String, String>> pet_list(int user_idx);
	public PetDTO pet_info(String pet_idx);
	public int update_pet(PetDTO dto);
	public int delete_pet(int pet_idx);
}
