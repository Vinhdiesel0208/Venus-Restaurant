package com.mytech.restaurantportal.controllers;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itextpdf.text.DocumentException;
import com.mytech.restaurantportal.exporters.IncomeExcelExport;
import com.restaurant.service.entities.Income;
import com.restaurant.service.services.IncomeService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/income")
public class IncomeController {

	@Autowired
	private IncomeService incomeService;

	@GetMapping("")
	public String getAllIncomes(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "1") int size,
			@RequestParam(name = "sortField", defaultValue = "day") String sortField, Model model) {

		Sort sort = Sort.by(sortField).descending(); // Default sort ascending by sortField
		PageRequest pageable = PageRequest.of(page - 1, size, sort);

		Page<Income> incomePage = incomeService.getAllIncomeByPage(pageable);
		List<LocalDateTime> distinctDays = incomeService.getDistinctDays().stream().sorted(Comparator.reverseOrder())
				.collect(Collectors.toList());

		model.addAttribute("incomes", incomePage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", incomePage.getTotalPages());
		model.addAttribute("moduleURL", "/income");
		model.addAttribute("size", size);
		model.addAttribute("sortField", sortField);
		model.addAttribute("distinctDays", distinctDays);

		return "/apps/income/list";
	}

//	@PostMapping("/export")
//	public void export(HttpServletResponse response, @RequestParam(name = "format") String format,
//			@RequestParam(name = "date") String date) throws IOException, DocumentException {
//		System.out.println("Income export: " + format);
//		System.out.println("Income export: " + date);
//		List<Income> listIncome = incomeService.getAllIncomes();
//
//		if ("excel".equals(format)) {
//			IncomeExcelExport exporter = new IncomeExcelExport();
//			exporter.export(listIncome, response);
//		}
//	}

	@GetMapping("/export/excel")
	public void exportToExcel(HttpServletResponse response) throws IOException {
		List<Income> listIncome = incomeService.getAllIncomes();
		IncomeExcelExport exporter = new IncomeExcelExport();
		exporter.export(listIncome, response);
	}

	@PostMapping("/export")
	public String export(HttpServletResponse response, @RequestParam(name = "format") String format,
			@RequestParam(name = "date", required = false) String date, RedirectAttributes redirectAttributes,
			Model model) throws IOException {
		List<Income> listIncome = new ArrayList<>();

		System.out.println("Income export: " + format);
		System.out.println("Income export day: " + date);

		try {
			if (date != null && !date.isEmpty()) {
				if (date.contains(" to ")) {
					String[] dates = date.split(" to ");
					LocalDate startDate = LocalDate.parse(dates[0].trim());
					LocalDate endDate = LocalDate.parse(dates[1].trim());
					listIncome = incomeService.getIncomesByDateRange(startDate, endDate);
				} else {
					LocalDate selectedDate = LocalDate.parse(date.trim());
					listIncome = incomeService.getIncomesByDate(selectedDate);
				}
			} else {
				listIncome = incomeService.getAllIncomes();
			}

			if (listIncome.isEmpty()) {
				redirectAttributes.addFlashAttribute("errorMessage",
						"No data available for the selected date or date range");
				return "redirect:/income"; 
			}

			if ("excel".equals(format)) {
				IncomeExcelExport exporter = new IncomeExcelExport();
				exporter.export(listIncome, response);
			}
		} catch (DateTimeParseException e) {
			System.out.println("Date format error: " + e.getMessage());
			redirectAttributes.addFlashAttribute("errorMessage", "Invalid date format");
			return "redirect:/income";
		}

		return "redirect:/income";
	}

}
