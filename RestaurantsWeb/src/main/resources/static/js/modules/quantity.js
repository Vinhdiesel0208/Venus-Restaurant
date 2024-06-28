CNVS.Quantity = function() {
	var __core = SEMICOLON.Core;

	//Trung3T
	function updateCartLine(cartLineId, quantity) {
		url = contextPath + "apis/test/cart/update/" + cartLineId + "/" + quantity;
		//url =  "http://localhost:8080/apis/test/cart/update/" + cartLineId + "/" + quantity;
		console.log('-------------' + url);
		jQuery.ajax({
			type: "POST",
			url: url,
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfValue);
			}
		}).done(function(updatedSubtotal) {
			console.log('-------------' + updatedSubtotal);
			updateSubtotal(cartLineId, updatedSubtotal);
		}).fail(function() {
			showErrorModal("Error while updating product quantity.");
		});
	}

	function updateSubtotal(cartLineId, updatedSubtotal) {
		jQuery("#cart_line_subtotal_" + cartLineId).text(updatedSubtotal.cartLineTotal);
		jQuery("#cart_total").text(updatedSubtotal.total);
		jQuery("#cart_subtotal").text(updatedSubtotal.subTotal);
	}

	return {
		init: function(selector) {
			if (__core.getSelector(selector, false, false).length < 1) {
				return true;
			}

			__core.initFunction({ class: 'has-plugin-quantity', event: 'pluginQuantityReady' });

			selector = __core.getSelector(selector, false);
			if (selector.length < 1) {
				return true;
			}

			selector.forEach(function(element) {
				var plus = element.querySelector('.plus'),
					minus = element.querySelector('.minus'),
					input = element.querySelector('.qty');

				var cartLine = element.querySelector('.cart_item_id');

				var eventChange = new Event("change");

				plus && (plus.onclick = function(e) {
					e.preventDefault();

					var value = input.value,
						step = input.getAttribute('step') || 1,
						max = input.getAttribute('max'),
						intRegex = /^\d+$/;

					if (max && (Number(elValue) >= Number(max))) {
						return false;
					}

					var valuePlus = step;

					if (intRegex.test(value)) {
						valuePlus = Number(value) + Number(step);
					}

					input.value = valuePlus;

					if (cartLine != null) {
						updateCartLine(cartLine.value, valuePlus);
					}

					input.dispatchEvent(eventChange);
				});

				minus && (minus.onclick = function(e) {
					e.preventDefault();

					var value = input.value,
						step = input.getAttribute('step') || 1,
						min = input.getAttribute('min'),
						intRegex = /^\d+$/;

					if (!min || min < 0) {
						min = 1;
					}
					
					var valueMinus = step;

					if (intRegex.test(value)) {
						if (Number(value) > Number(min)) {
							valueMinus = Number(value) - Number(step);
						}
					}
					
					input.value = valueMinus;
					
					if (cartLine != null) {
						updateCartLine(cartLine.value, valueMinus);
					}

					input.dispatchEvent(eventChange);
				});
			});
		}
	};
}();
