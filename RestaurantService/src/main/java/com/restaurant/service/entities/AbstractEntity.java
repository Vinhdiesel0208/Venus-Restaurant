package com.restaurant.service.entities;
import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.Version;
import lombok.Data;

import java.time.LocalDateTime;
@Data
@MappedSuperclass
public abstract class AbstractEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long id;
    @Version
    protected Long version;
    @Column(name = "created_on")
    protected LocalDateTime createdOn;
    @Column(name = "updated_on")
    protected LocalDateTime updatedOn;
	public Long getId() {
		return this.id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getVersion() {
		return this.version;
	}
	public void setVersion(Long version) {
		this.version = version;
	}
	public LocalDateTime getCreatedOn() {
		return this.createdOn;
	}
	public void setCreatedOn(LocalDateTime createdOn) {
		this.createdOn = createdOn;
	}
	public LocalDateTime getUpdatedOn() {
		return this.updatedOn;
	}
	public void setUpdatedOn(LocalDateTime updatedOn) {
		this.updatedOn = updatedOn;
	}
}
