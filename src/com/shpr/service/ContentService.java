package com.shpr.service;

import java.util.List;

import com.shpr.pojo.Collection;
import com.shpr.pojo.Content;
import com.shpr.pojo.ShoppingActive;
import com.shpr.pojo.ShoppingUserSimilarity;
import com.shpr.pojo.User;

public interface ContentService {

	public List<Content>getContentist();

	public void deleteContent(int[] ids);

	public int saveContentInfo(Content content);

	public int updateClick(Content count);

	public Content selectById(Integer id);

	public List<Content> secleteAuthor(String author);

	public int updataContentInfo(Content contente);

	public User secleteUserhobby(String author);

	public List<Content> UserSearch(String content);

	public int SaveCollection(Collection collection);

	public Collection findCollection(Integer id, String author);

	public void deleteCollection(Integer id, String author);

	public List<Collection> secleteContent(String author);

	public List<Content> secleteColle(int[] ids);

	public Content secleteContenthobby(String user_hobby, String user_specialty);

	public int insertState(int id, int hobby);

	public List<ShoppingActive> listAllUserActive();

	public List<ShoppingUserSimilarity> listUserSimilarityByUId(Long user_id);

	public int saveUserSimilarity(ShoppingUserSimilarity shoppingUserSimilarity);

	public boolean isExistsUserSimilarity(ShoppingUserSimilarity shoppingUserSimilarity);

	public int updateUserSimilarity(ShoppingUserSimilarity shoppingUserSimilarity);

	public List<Content> listContentInfo(Content content);

	public int saveUserActive(ShoppingActive shoppingActive);

	public Content getContentByContentId(int content_id);

	public boolean updateContentHitsByContentId(int content_id);

	public List<Content> listContentByCategory2Id(Long category2Id);






	 
}
