package com.restaurant.service.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.restaurant.service.entities.CartLine;
import com.restaurant.service.enums.OrderStatus;

public interface CartLineRepository extends JpaRepository<CartLine, Long> {

    // Xóa các dòng giỏ hàng theo tên bàn
    @Transactional
    @Modifying
    @Query("DELETE FROM CartLine c WHERE c.tableName = :tableName")
    void deleteByTableName(String tableName);
 // Định nghĩa lại phương thức trong repository để nhận trạng thái làm tham số và sắp xếp kết quả
 // Trong CartLineRepository
    @Query("SELECT c FROM CartLine c ORDER BY c.orderTime ASC")
    List<CartLine> findAllOrderByOrderTimeAsc();



    // Tìm một dòng giỏ hàng theo tên bàn và nguyên liệu
    CartLine findByTableNameAndIngredientId(String tableName, Long ingredientId);

    // Lấy danh sách các dòng giỏ hàng theo tên bàn
    List<CartLine> findByTableName(String tableName);
    
    // Lấy danh sách các dòng giỏ hàng theo trạng thái
    List<CartLine> findByStatus(OrderStatus status);
    
    
    //vinh check out complete
    @Transactional
    @Modifying
    @Query("UPDATE CartLine c SET c.status = :status WHERE c.tableName = :tableName AND c.status IN (:currentStatuses)")
    int updateStatusForTable(@Param("tableName") String tableName, @Param("status") OrderStatus newStatus, @Param("currentStatuses") List<OrderStatus> currentStatuses);
    @Transactional
    @Modifying
    @Query("UPDATE CartLine c SET c.status = :status WHERE c.restaurantTable.id = :tableId AND c.status IN :currentStatus")
    int updateStatusForTableByRestaurantTableId(@Param("tableId") Long tableId, @Param("status") OrderStatus newStatus, @Param("currentStatus") List<OrderStatus> currentStatus);

  
    @Transactional
    @Query("SELECT c FROM CartLine c WHERE c.restaurantTable.id = :tableId")
    List<CartLine> findByRestaurantTableId(@Param("tableId") Long tableId);

    @Transactional
    @Query("SELECT c FROM CartLine c WHERE c.restaurantTable.id = :tableId AND c.status = :status")
    List<CartLine> findByTableIdAndStatus(@Param("tableId") Long tableId, @Param("status") OrderStatus status);
    // Thêm phương thức này
    @Query("SELECT c FROM CartLine c WHERE c.tableName = :tableName AND c.status != :status")
    List<CartLine> findByTableNameAndStatusNot(@Param("tableName") String tableName, @Param("status") OrderStatus status);

    @Query("SELECT c FROM CartLine c WHERE c.tableName = :tableName AND c.status = :status")
    List<CartLine> findByTableNameAndStatus(@Param("tableName") String tableName, @Param("status") OrderStatus status);
}
