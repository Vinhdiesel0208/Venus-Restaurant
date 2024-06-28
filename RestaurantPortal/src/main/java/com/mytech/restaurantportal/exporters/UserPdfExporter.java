package com.mytech.restaurantportal.exporters;

import java.io.IOException;
import java.util.List;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.mytech.restaurantportal.exporters.AbstractExporter;
import com.restaurant.service.entities.User;

import jakarta.servlet.http.HttpServletResponse;


	public class UserPdfExporter extends AbstractExporter {

		public void export(List<User> listUsers, HttpServletResponse response) throws IOException, DocumentException {
			super.setResponseHeader(response, "application/pdf", ".pdf", "users_");
			
			Document document = new Document(PageSize.A4);
			PdfWriter.getInstance(document, response.getOutputStream());
			
			document.open();
			
			Font font = FontFactory.getFont(FontFactory.HELVETICA);
			font.setSize(20);
			font.setColor(BaseColor.ORANGE);
			
			Paragraph paragraph = new Paragraph("List of Users", font);
			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
			
			document.add(paragraph);
			
			PdfPTable table = new PdfPTable(7);
			table.setWidthPercentage(100f);
			table.setSpacingBefore(4);
			table.setWidths(new float[] {1.2f, 3.0f, 2.0f, 2.0f, 2.0f, 3f, 1.5f});
			
			writeTableHeader(table);
			writeTableData(table, listUsers);
			
			document.add(table);
			
			document.close();
			
		}

		private void writeTableData(PdfPTable table, List<User> listUsers) {
			for (User user : listUsers) {
				String createOn = "";
				if (user.getCreatedOn() != null) {
					createOn = user.getCreatedOn().toString();
				}
				
				table.addCell(getPdfPCell(String.valueOf(user.getId())));
				table.addCell(getPdfPCell(user.getEmail()));
				table.addCell(getPdfPCell(user.getFirstName()));
				table.addCell(getPdfPCell(user.getLastName()));
				table.addCell(getPdfPCell(createOn));
				table.addCell(getPdfPCell(user.getRoles().toString()));
				table.addCell(getPdfPCell(String.valueOf(user.isEnabled())));
			}
		}
		
		private PdfPCell getPdfPCell(String content) {
			PdfPCell cell = new PdfPCell();
			cell.setPadding(5);
			
			Font font = FontFactory.getFont(FontFactory.HELVETICA);
			font.setSize(10);
			
			cell.setPhrase(new Phrase(content, font));
			
			return cell;
		}

		private void writeTableHeader(PdfPTable table) {
			PdfPCell cell = new PdfPCell();
			cell.setBackgroundColor(BaseColor.ORANGE);
			cell.setPadding(5);
			
			Font font = FontFactory.getFont(FontFactory.HELVETICA);
			font.setColor(BaseColor.WHITE);
			font.setSize(10);
			
			cell.setPhrase(new Phrase("Id", font));		
			table.addCell(cell);
			
			cell.setPhrase(new Phrase("Email", font));		
			table.addCell(cell);
			
			cell.setPhrase(new Phrase("First Name", font));		
			table.addCell(cell);
			
			cell.setPhrase(new Phrase("Last Name", font));		
			table.addCell(cell);
			
			cell.setPhrase(new Phrase("Created On", font));		
			table.addCell(cell);
			
			cell.setPhrase(new Phrase("Roles ", font));
			table.addCell(cell);
			
			cell.setPhrase(new Phrase("Enabled", font));		
			table.addCell(cell);		
		}
	}