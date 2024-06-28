package com.mytech.restaurantportal.exporters;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import com.restaurant.service.entities.Income;
import com.restaurant.service.entities.IncomeItem;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

public class IncomeExcelExport extends AbstractExporter {
    private XSSFWorkbook workbook;
    private XSSFCellStyle cellStyle;
    private XSSFFont font;
	private XSSFSheet sheet;

    public IncomeExcelExport() {
        workbook = new XSSFWorkbook();
        cellStyle = workbook.createCellStyle();
        font = workbook.createFont();
        font.setFontHeight(14);
        cellStyle.setFont(font);
    }
    private String formatSheetName(LocalDateTime dateTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd_MM");
        return "IncomeDay" + dateTime.format(formatter);
    }
    private void writeHeaderLine(LocalDateTime dateTime) {
    	
    	String sheetName = formatSheetName(dateTime);
        sheet = workbook.createSheet(sheetName);
    	XSSFRow row = sheet.createRow(0);
    	
        XSSFCellStyle cellStyle = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setBold(true);
        font.setFontHeight(14);
        cellStyle.setFont(font);
        cellStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        cellStyle.setBorderTop(BorderStyle.MEDIUM);
        cellStyle.setBorderBottom(BorderStyle.MEDIUM);
        cellStyle.setBorderLeft(BorderStyle.MEDIUM);
        cellStyle.setBorderRight(BorderStyle.MEDIUM);
       
        
        sheet.setColumnWidth(0, 10 * 256); 
        sheet.setColumnWidth(1, 20 * 256); 
        sheet.setColumnWidth(2, 20 * 256); 
        sheet.setColumnWidth(3, 20 * 256); 
        sheet.setColumnWidth(4, 20 * 256); 
        sheet.setColumnWidth(5, 20 * 256); 
        sheet.setColumnWidth(6, 20 * 256); 
  
        createCell(row, 0, "ID", cellStyle);
        createCell(row, 1, "Ingredient Code", cellStyle);
        createCell(row, 2, "Ingredient Name", cellStyle);
        createCell(row, 3, "Category Name", cellStyle);
        createCell(row, 4, "Sold quantity", cellStyle);
        createCell(row, 5, "Price", cellStyle);
        createCell(row, 6, "Total Price", cellStyle);
    
    }

    private void createCell(XSSFRow row, int columnIndex, Object value, CellStyle style) {
        XSSFCell cell = row.createCell(columnIndex);
        if (value instanceof BigDecimal) {
            BigDecimal decimalValue = (BigDecimal) value;
            cell.setCellValue(decimalValue.toString());
        } else if (value instanceof Integer) {
            cell.setCellValue((Integer) value);
        } else if (value instanceof Long) {
            cell.setCellValue((Long) value);
        } else if (value instanceof Boolean) {
            cell.setCellValue((Boolean) value);
        } else {
            cell.setCellValue((String) value);
        }

        cell.setCellStyle(style);
    }
    private void writeDataLines(XSSFSheet sheet, List<IncomeItem> incomeItems) {
        int rowIndex = 1;
        for (IncomeItem incomeItem : incomeItems) {
            XSSFRow row = sheet.createRow(rowIndex++);
            int columnIndex = 0;

            createCell(row, columnIndex++, incomeItem.getId(), cellStyle);
            createCell(row, columnIndex++, incomeItem.getIngredient().getIngredientCode(), cellStyle);
            createCell(row, columnIndex++, incomeItem.getIngredient().getIngredientName(), cellStyle);
            createCell(row, columnIndex++, incomeItem.getIngredient().getCategory().getCategoryName(), cellStyle);
            createCell(row, columnIndex++, incomeItem.getSoldQuantity(), cellStyle);
            createCell(row, columnIndex++, incomeItem.getPrice(), cellStyle);
            createCell(row, columnIndex++, incomeItem.getTotalPrice(), cellStyle);
    
        }
    }

 
    	  public void export(List<Income> incomeList, HttpServletResponse response) {
    		  XSSFCellStyle cellTotal = workbook.createCellStyle();
    		  	cellTotal.setFont(font);
    	        cellTotal.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.getIndex());
    	        cellTotal.setFillPattern(FillPatternType.SOLID_FOREGROUND);
    	        cellTotal.setBorderTop(BorderStyle.MEDIUM);
    	        cellTotal.setBorderBottom(BorderStyle.MEDIUM);
    	        cellTotal.setBorderLeft(BorderStyle.MEDIUM);
    	        cellTotal.setBorderRight(BorderStyle.MEDIUM);
    	        try {
    	            super.setResponseHeader(response, "application/octet-stream", ".xlsx", "income_");
    	            for (Income income : incomeList) { 
    	                    writeHeaderLine(income.getDay());
    	                    writeDataLines(sheet, income.getIncomeItems());
    	                    
    	                    XSSFRow totalIncomeRow = sheet.createRow(sheet.getLastRowNum() + 1);
    	                    int columnIndex = 0;
    	                    for (int i = 0; i < 5; i++) {
    	                        createCell(totalIncomeRow, columnIndex++, "", cellStyle); // Để trống các ô trước cột Total Income
    	                    }
    	                    createCell(totalIncomeRow, columnIndex++, "Total Income", cellTotal);
    	                    createCell(totalIncomeRow, columnIndex, income.getTotalIncome(), cellTotal); 
    	                    
    	                }
    	            ServletOutputStream outputStream = response.getOutputStream();
    	            workbook.write(outputStream);
    	            outputStream.close();
    	            workbook.close();
    	        } catch (Exception e) {
    	            System.out.println("IncomeExcelExport exception:  " + e.getMessage());
    	        }
    	    }
}