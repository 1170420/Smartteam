package com.shpr.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shpr.pojo.Collection;
import com.shpr.pojo.Content;
import com.shpr.pojo.ShoppingActive;
import com.shpr.pojo.ShoppingUserSimilarity;
import com.shpr.pojo.User;

public interface ContentDao {
	
	public List<Content> getContentist();
	
	public void deleteContent(int[] ids);

	public int saveContentInfo(Content content);

	public int updateClick(Content count);

	public Content selectById(@Param("id") Integer id);

	public List<Content> secleteAuthor(String author);

	public int updataContentInfo(Content content);

	public User secleteUserhobby(@Param("user_name")String author);

	public List<Content> UserSearch(@Param("content")String content);

	public int SaveCollection(Collection collection);

	public Collection findCollection(@Param("id") Integer id, @Param("author")String author);

	public void deleteCollection(@Param("id") Integer id,@Param("author")String author);

	public List<Collection> secleteContent(String author);

	public List<Content> secleteColle(int[] ids);

	public Content secleteContenthobby(@Param("user_hobby") String user_hobby, @Param("user_specialty")String user_specialty);

	public int insertState(int id, int hobby);

	public List<ShoppingActive> listAllUserActive();

	public List<ShoppingUserSimilarity> listUserSimilarityByUId(@Param("user_id") Long user_id);

	public int saveUserSimilarity(ShoppingUserSimilarity shoppingUserSimilarity);

	public ShoppingUserSimilarity isExistsUserSimilarity(ShoppingUserSimilarity shoppingUserSimilarity);

	public int updateUserSimilarity(ShoppingUserSimilarity shoppingUserSimilarity);

	public List<Content> listContentInfo(Content content);

	public Long countUserActive(ShoppingActive shoppingActive);

	public int saveUserActive(ShoppingActive shoppingActive);

	public Long getHitsByUserActiveInfo(ShoppingActive shoppingActive);

	public int updateUserActive(ShoppingActive shoppingActive);

	public int updateContent(Content content);

	public Content getContentByContentId(int content_id);

	public int getContentHitsByCId(int content_id);

	public List<Content> listContent(Content content);

	public int countUserSimilarity(ShoppingUserSimilarity shoppingUserSimilarity);







}
