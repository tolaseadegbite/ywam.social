// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import controllers from "./**/*_controller.js"
controllers.forEach((controller) => {
  application.register(controller.name, controller.module.default)
})

// import FormElementController from "./form_element_controller"
// application.register("form-element", FormElementController)

// import FormRefreshController from "./form_refresh_controller"
// application.register("form-refresh", FormRefreshController)

// import HelloController from "./hello_controller"
// application.register("hello", HelloController)

// import MessagePreviewController from "./message_preview_controller"
// application.register("message-preview", MessagePreviewController)

// import NavigateController from "./navigate_controller"
// application.register("navigate", NavigateController)

// import RemovalsController from "./removals_controller"
// application.register("removals", RemovalsController)

// import ResetFormController from "./reset_form_controller"
// application.register("reset-form", ResetFormController)

// import ScrollController from "./scroll_controller"
// application.register("scroll", ScrollController)
