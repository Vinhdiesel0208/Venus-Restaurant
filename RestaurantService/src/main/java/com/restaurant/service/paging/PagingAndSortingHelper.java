package com.restaurant.service.paging;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.ui.Model;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.restaurant.service.repositories.SearchRepository;

public class PagingAndSortingHelper {
	private Model model;
	private String listName;
	private String sortField;
	private String sortDir;
	private String searchText;
	
	public PagingAndSortingHelper(Model model,String listName,
			String sortField, String sortDir, String searchText) {
		this.model = model;
		this.listName = listName;
		this.sortField = sortField;
		this.sortDir = sortDir;
		this.searchText = searchText;
	}
	
	private Map<String, String> searchFields;

    public PagingAndSortingHelper() {

        searchFields = new HashMap<>();
    }

    public void addSearchField(String fieldName, String value) {
        searchFields.put(fieldName, value);
    }

	
	public void updateModelAttributes(int pageNum, Page<?> page) {
		List<?> listItems = page.getContent();
		int pageSize = page.getSize();
		
		long startCount = (pageNum - 1) * pageSize + 1;
		long endCount = startCount + pageSize - 1;
		if (endCount > page.getTotalElements()) {
			endCount = page.getTotalElements();
		}
		
		String params = "";

		if (sortField != null && !sortField.endsWith("")) {
			params += "sortField=" + sortField;
			params += "&sortDir=" + (sortDir != null ? sortDir : "asc");
		}

		if (searchText != null && !searchText.equals("")) {
			params += (params.equals("") ? "searchText=" : "&searchText=") + searchText;
		}

		String queryParams = params.equals("") ? "" : "?" + params;
		
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("startCount", startCount);
		model.addAttribute("endCount", endCount);
		model.addAttribute("totalItems", page.getTotalElements());
		model.addAttribute(listName, listItems);
		model.addAttribute("queryParams", queryParams);
		
		System.out.println("Current page: " + pageNum);
		System.out.println("Total page: " + page.getTotalPages());
		System.out.println("Start count: " + startCount);
		System.out.println("End count: " + endCount);
		System.out.println("Total items: " + page.getTotalElements());
	}
	
	public void listEntities(int pageNum, int pageSize, SearchRepository<?, Long> repo) {
		Pageable pageable = createPageable(pageSize, pageNum);
		Page<?> page = null;
		
		if (searchText != null) {
			page = repo.findAll(searchText, pageable);
		} else {
			page = repo.findAll(pageable);
		}
		
		updateModelAttributes(pageNum, page);		
	}
	

	
	public Pageable createPageable(int pageSize, int pageNum) {
		Sort sort = Sort.by(sortField);
		sort = sortDir.equals("asc") ? sort.ascending() : sort.descending();
		return PageRequest.of(pageNum - 1, pageSize, sort);		
	}	

	public String getSortField() {
		return sortField;
	}

	public String getSortDir() {
		return sortDir;
	}

	public String getSearchText() {
		return searchText;
	}
}
