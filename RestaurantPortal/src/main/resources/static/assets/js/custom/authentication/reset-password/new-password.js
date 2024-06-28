"use strict";
var KTAuthNewPassword = (function () {
  var t,
    e,
    r,
    o,
    a = function () {
      return 100 === o.getScore();
    };
  return {
    init: function () {
      (t = document.querySelector("#kt_new_password_form")),
        (e = document.querySelector("#kt_new_password_submit")),
        (o = KTPasswordMeter.getInstance(
          t.querySelector('[data-kt-password-meter="true"]')
        )),
        (r = FormValidation.formValidation(t, {
          fields: {
            password: {
              validators: {
                notEmpty: { message: "The password is required" },
                callback: {
                  message: "Please enter valid password",
                  callback: function (t) {
                    if (t.value.length > 0) return a();
                  },
                },
              },
            },
            "confirm-password": {
              validators: {
                notEmpty: { message: "The password confirmation is required" },
                identical: {
                  compare: function () {
                    return t.querySelector('[name="password"]').value;
                  },
                  message: "The password and its confirm are not the same",
                },
              },
            },
            toc: {
              validators: {
                notEmpty: {
                  message: "You must accept the terms and conditions",
                },
              },
            },
          },
          plugins: {
            trigger: new FormValidation.plugins.Trigger({
              event: { password: !1 },
            }),
            bootstrap: new FormValidation.plugins.Bootstrap5({
              rowSelector: ".fv-row",
              eleInvalidClass: "",
              eleValidClass: "",
            }),
          },
        })),
        e.addEventListener("click", function (a) {
          a.preventDefault(),
            r.revalidateField("password"),
            r.validate().then(function (r) {
              "Valid" == r
                ? t.submit()
                : Swal.fire({
                    text: "Sorry, looks like there are some errors detected, please try again.",
                    icon: "error",
                    buttonsStyling: !1,
                    confirmButtonText: "Ok, got it!",
                    customClass: { confirmButton: "btn btn-primary" },
                  });
            });
        }),
        t
          .querySelector('input[name="password"]')
          .addEventListener("input", function () {
            this.value.length > 0 &&
              r.updateFieldStatus("password", "NotValidated");
          });
    },
  };
})();
KTUtil.onDOMContentLoaded(function () {
  KTAuthNewPassword.init();
});
