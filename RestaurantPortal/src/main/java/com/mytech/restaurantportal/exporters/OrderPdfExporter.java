package com.mytech.restaurantportal.exporters;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.restaurant.service.entities.OrderItem;

import jakarta.servlet.http.HttpServletResponse;

public class OrderPdfExporter extends AbstractExporter {

	public void export(List<OrderItem> orderItems, HttpServletResponse response) throws IOException, DocumentException {
		super.setResponseHeader(response, "application/pdf", ".pdf", "order_items_");

		Document document = new Document(PageSize.A4);
		PdfWriter.getInstance(document, response.getOutputStream());

		document.open();
		writeRestaurantInfo(document);

		// Add order details
		writeOrderDetails(document, orderItems);

		PdfPTable table = new PdfPTable(4);
		table.setWidthPercentage(100f);

		// Add table header
		writeTableHeader(table);

		// Add table data
		writeTableData(table, orderItems);

		document.add(table);

		// Add additional order information horizontally
		writeAdditionalOrderInfo(document, orderItems);

		document.close();
	}
	
	 private void writeRestaurantInfo(Document document) throws DocumentException {
	        Font font = FontFactory.getFont(FontFactory.HELVETICA);
	        font.setColor(BaseColor.BLACK);
	        font.setSize(12);

	        PdfPTable restaurantInfoTable = new PdfPTable(2);
	        restaurantInfoTable.setWidthPercentage(100f);

	        // Add restaurant name
	        PdfPCell cell = new PdfPCell(new Phrase("Restaurant: Venus Restaurant", font));
	        cell.setBorder(PdfPCell.NO_BORDER);
	        restaurantInfoTable.addCell(cell);

	        // Add restaurant address
	        cell = new PdfPCell(new Phrase("Address: 1280 Cach Mang Thang 8", font));
	        cell.setBorder(PdfPCell.NO_BORDER);
	        restaurantInfoTable.addCell(cell);

	        // Add restaurant contact
	        cell = new PdfPCell(new Phrase("Tel: 0903222222", font));
	        cell.setBorder(PdfPCell.NO_BORDER);
	        restaurantInfoTable.addCell(cell);

	        document.add(restaurantInfoTable);

	        // Add spacing
	        document.add(new Phrase("\n")); // Add some spacing between restaurant info and order details
	    }

	 private void writeOrderDetails(Document document, List<OrderItem> orderItems) throws DocumentException {
		    Font font = FontFactory.getFont(FontFactory.HELVETICA);
		    font.setColor(BaseColor.BLACK);
		    font.setSize(12);

		    PdfPTable orderDetailsTable = new PdfPTable(2);
		    orderDetailsTable.setWidthPercentage(100f);

		    // Add customer name
		    PdfPCell cell = new PdfPCell(new Phrase("Customer Name:", font));
		    cell.setBorder(PdfPCell.NO_BORDER);
		    cell.setFixedHeight(20f); // Set fixed height for the cell
		    orderDetailsTable.addCell(cell);

		    // Add order time
		    cell = new PdfPCell(new Phrase("Order Time:", font));
		    cell.setBorder(PdfPCell.NO_BORDER);
		    cell.setFixedHeight(20f); // Set fixed height for the cell
		    orderDetailsTable.addCell(cell);

		    // Add customer name value
		    cell = new PdfPCell(new Phrase(orderItems.get(0).getOrder().getFullName(), font));
		    cell.setBorder(PdfPCell.NO_BORDER);
		    cell.setFixedHeight(20f); // Set fixed height for the cell
		    orderDetailsTable.addCell(cell);

		    // Add order time value
		    LocalDateTime ordertime = orderItems.get(0).getOrder().getOrdertime();
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
		    String formattedDate = ordertime.format(formatter);
		    cell = new PdfPCell(new Phrase(formattedDate, font));
		    cell.setBorder(PdfPCell.NO_BORDER);
		    cell.setFixedHeight(20f); // Set fixed height for the cell
		    orderDetailsTable.addCell(cell);

		    document.add(orderDetailsTable);

		    // Add spacing
		    document.add(new Phrase("\n")); // Add some spacing between order details and table
		}


	private void writeTableHeader(PdfPTable table) {
		PdfPCell cell = new PdfPCell();
		cell.setBackgroundColor(BaseColor.ORANGE);
		cell.setPadding(5);

		Font font = FontFactory.getFont(FontFactory.HELVETICA);
		font.setColor(BaseColor.WHITE);
		font.setSize(10);

		// Add header cells
		cell.setPhrase(new Phrase("Order ID", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Ingredient Name", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Quantity", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Price", font));
		table.addCell(cell);
	}

	private void writeTableData(PdfPTable table, List<OrderItem> orderItems) {
		int rowCount = 1; // Initialize the row count

		for (OrderItem orderItem : orderItems) {
			// Add the row number instead of the order ID
			table.addCell(String.valueOf(rowCount));
			table.addCell(orderItem.getIngredient().getIngredientName());
			table.addCell(String.valueOf(orderItem.getQuantity()));
			table.addCell(String.valueOf(orderItem.getPrice()));

			rowCount++; // Increment the row count for the next iteration
		}
	}
	
	

	private void writeAdditionalOrderInfo(Document document, List<OrderItem> orderItems) throws DocumentException {
	    Font font = FontFactory.getFont(FontFactory.HELVETICA);
	    font.setColor(BaseColor.BLACK);
	    font.setSize(8);
	    
	    PdfPTable additionalInfoTable = new PdfPTable(12);
	    additionalInfoTable.setWidthPercentage(100f);
	    additionalInfoTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
	    
	    // Set spacing before the table
	    additionalInfoTable.setSpacingBefore(1f); // Adjust the spacing value as needed
	    
	    // Add table number
	    addTableCell(additionalInfoTable, "Table:", orderItems.get(0).getOrder().getRestaurantTable().getTableNumber(), font);
	    
	    // Add total
	    addTableCell(additionalInfoTable, "Total:", String.valueOf(orderItems.get(0).getOrder().getTotal1()), font);
	    
	    // Add tax
	    addTableCell(additionalInfoTable, "Tax:", String.valueOf(orderItems.get(0).getOrder().getTax()), font);
	    
	    // Add tip
	    addTableCell(additionalInfoTable, "Tip:", String.valueOf(orderItems.get(0).getOrder().getTips()), font);
	    
	    // Add discount
	    addTableCell(additionalInfoTable, "Rebate:", String.valueOf(orderItems.get(0).getOrder().getDiscount()), font);
	    
	    // Add a blank row
	    PdfPCell blankCell = new PdfPCell(new Phrase("")); // Empty phrase to create a blank cell
	    blankCell.setBorder(PdfPCell.NO_BORDER);
	    blankCell.setColspan(12); // Span across all columns
	    additionalInfoTable.addCell(blankCell);
	    
	    // Add "Grand" and its value in bold with a top border
	    PdfPCell grandLabelCell = new PdfPCell(new Phrase("Grand:", font));
	    grandLabelCell.setBorder(PdfPCell.TOP);
	    grandLabelCell.setPaddingRight(10f);
	    additionalInfoTable.addCell(grandLabelCell);

	    PdfPCell grandValueCell = new PdfPCell(new Phrase(String.valueOf(orderItems.get(0).getOrder().getTotal()), font));
	    grandValueCell.setBorder(PdfPCell.TOP);
	    grandValueCell.setPaddingRight(10f);
	    grandValueCell.setColspan(11); // Merge with the remaining cells in the row
	    additionalInfoTable.addCell(grandValueCell);
	    
	    document.add(additionalInfoTable);
	}


	private void addTableCell(PdfPTable table, String label, String value, Font font) {
	    PdfPCell labelCell = new PdfPCell(new Phrase(label, font));
	    labelCell.setBorder(PdfPCell.NO_BORDER);
	    labelCell.setPaddingRight(10f);
	    table.addCell(labelCell);

	    PdfPCell valueCell = new PdfPCell(new Phrase(value, font));
	    valueCell.setBorder(PdfPCell.NO_BORDER);
	    valueCell.setPaddingRight(10f);
	    table.addCell(valueCell);
	}


}
