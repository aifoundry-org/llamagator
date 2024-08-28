// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"
import AssertionController from "./assertion_controller"
import AssertionResultModalController from "./assertion_result_modal_controller"
import ModelController from "./model_controller"
import CompareController from "./compare_controller";

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
application.register("assertion", AssertionController)
application.register("assertionResultModal", AssertionResultModalController)
application.register("model", ModelController)
application.register("compare", CompareController);

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
