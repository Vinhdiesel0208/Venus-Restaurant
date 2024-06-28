package com.restaurant.service.entities;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Entity
@Table(name = "tables")
public class TableM extends AbstractEntity {
	private static final long serialVersionUID = 1L;

	@NotBlank(message = "Name is required")
	@Column(name = "name_table")
	private String name_table;

	@NotBlank(message = "Description is required")
	@Column(name = "description")
	private String description;

	@NotBlank(message = "Capacity is required")
	@Column(name = "capacity")
	private String capacity;

public String getName_table() {
		return name_table;
	}

	public void setName_table(String name_table) {
		this.name_table = name_table;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCapacity() {
		return capacity;
	}

	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}

	public List<Reservation> getaList() {
		return aList;
	}

	public void setaList(List<Reservation> aList) {
		this.aList = aList;
	}
	@OneToMany(mappedBy = "tableM", fetch = FetchType.LAZY)
	private List<Reservation> aList;

	public TableM() {
		super();
	}
	
	@Transient
	public String getCodeName() {
		return name_table + " - " + description;
	}
	
	@Override
	public String toString() {
		return "TableM[id=" + getId() + ", name_table=" + name_table + ", description=" + description + ", capacity="
				+ capacity + "]";
	}

	
}
