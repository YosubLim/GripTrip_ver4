package spring.trip.model.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import spring.trip.LifeCycle.ServletInit;
import spring.trip.domain.Story;
import spring.trip.model.dao.StoryDAO;
import spring.trip.model.service.StoryService;

@Service
public class StoryServiceImpl implements StoryService{
	@Autowired
	private StoryDAO storyDAO;
	private String path = ServletInit.path;

	@Override
	public void uploadStoryPhoto(Story story) throws Exception {
		MultipartFile mFile = story.getUploadFile();
		
		System.out.println("name"+ mFile);
		if(mFile!=null){
			if(mFile.getOriginalFilename()!=""){
				String fileName = mFile.getOriginalFilename();
			
				String newFileName = System.currentTimeMillis()+"_"+mFile.getOriginalFilename();
				story.setStoryPictureUrl(newFileName);
				
				File copyFile = new File(path+newFileName);
				mFile.transferTo(copyFile);
				System.out.println("uploadStoryPhoto" + story.getStoryPictureUrl());
			}
		}
	}

	@Override
	public void insertStoryInfo(Story story) throws Exception {
		storyDAO.insertStoryInfo(story);
	}

	@Override
	public void updateStory(Story story) throws Exception {
		storyDAO.updateStory(story);
	}

	@Override
	public void deleteStory(String storyNo) throws Exception {
		storyDAO.deleteStory(storyNo);
	}

/*	@Override
	public Story showStory(String storyNo) throws Exception {
		return storyDAO.showStory(storyNo);
	}*/

	@Override
	public void upStoryHit(String storyNo) throws Exception {
		storyDAO.upStoryHit(storyNo);
	}

	@Override
	public List<Story> showStoryList(String bookNo) throws Exception {
		return storyDAO.showStoryList(bookNo);
	}

	@Override
	public void fileDelete(String storyPictureUrl) throws Exception {
		File f = new File(path+storyPictureUrl);
		System.out.println(storyPictureUrl+" file Delete!"+f.delete());
	}

	@Override
	public void deleteUrl(String storyNo) throws Exception {
		storyDAO.deleteUrl(storyNo);
	}

	@Override
	public void updateStoryBookmark(String storyNo) throws Exception {
		storyDAO.updateStoryBookmark(storyNo);
	}

	@Override
	public Story getStoryByStoryNo(String storyNo) throws Exception {
		return storyDAO.getStoryByStoryNo(storyNo);
	}

	@Override
	public void deleteStoryBookmark(String storyNo) throws Exception {
		storyDAO.deleteStoryBookmark(storyNo);
	}

	@Override
	public List<Story> allStoryList() throws Exception {
		return storyDAO.allStoryList();
	}

	@Override
	public List<Story> otherStoryList(String email) throws Exception {
		return storyDAO.otherStoryList(email);
	}

	@Override
	public List<Story> searchStory(String keyword) throws Exception {
		return storyDAO.searchStory(keyword);
	}

	@Override
	public List<Story> searchStoryByTitle(String keyword) throws Exception {
		return storyDAO.searchStoryByTitle(keyword);
	}

	@Override
	public List<Story> searchStoryByContent(String keyword) throws Exception {
		return storyDAO.searchStoryByContent(keyword);
	}

	@Override
	public List<Story> searchStoryByLocation(String keyword) throws Exception {
		return storyDAO.searchStoryByLocation(keyword);
	}

	@Override
	public List<Story> allStoryListByHit() throws Exception {
		return storyDAO.allStoryListByHit();
	}

	@Override
	public List<Story> searchStoryOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return storyDAO.searchStoryOrderByHit(keyword);
	}

	@Override
	public List<Story> searchStoryByTitleOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return storyDAO.searchStoryByTitleOrderByHit(keyword);
	}

	@Override
	public List<Story> searchStoryByContentOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return storyDAO.searchStoryByContentOrderByHit(keyword);
	}

	@Override
	public List<Story> searchStoryByLocationOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return storyDAO.searchStoryByLocationOrderByHit(keyword);
	}

	@Override
	public void upStoryBookmarkCount(int storyNo) throws Exception {
		storyDAO.upStoryBookmarkCount(storyNo);		
	}

	@Override
	public void downStoryBookmarkCount(int storyNo) throws Exception {
		storyDAO.downStoryBookmarkCount(storyNo);
	}

	@Override
	public List<Story> allStoryListOrderByBookmark() throws Exception {
		// TODO Auto-generated method stub
		return storyDAO.allStoryListOrderByBookmark();
	}

	@Override
	public List<Story> searchStoryOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return storyDAO.searchStoryOrderByBookmark(keyword);
	}

	@Override
	public List<Story> searchStoryByTitleOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return storyDAO.searchStoryByTitleOrderByBookmark(keyword);
	}

	@Override
	public List<Story> searchStoryByContentOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return storyDAO.searchStoryByContentOrderByBookmark(keyword);
	}

	@Override
	public List<Story> searchStoryByLocationOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return storyDAO.searchStoryByLocationOrderByBookmark(keyword);
	}
}