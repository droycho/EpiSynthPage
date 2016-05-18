import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import spark.ModelAndView;
import spark.template.velocity.VelocityTemplateEngine;
import static spark.Spark.*;

public class App {
  public static void main(String[] args) {
    staticFileLocation("/public");
    String layout = "templates/layout.vtl";

    get("/", (request, response) -> {
      Map<String, Object> model = new HashMap<String, Object>();
      model.put("template", "templates/index.vtl");
      return new ModelAndView(model, layout);
    }, new VelocityTemplateEngine());

    get("/processing", (request, response) -> {
      HashMap<String, Object> model = new HashMap<String, Object>();
      model.put("template", "templates/processing.vtl");
      return new ModelAndView(model,layout);
    }, new VelocityTemplateEngine());

    get("/modular", (request, response) -> {
      HashMap<String, Object> model = new HashMap<String, Object>();
      model.put("template", "templates/modular.vtl");
      return new ModelAndView(model,layout);
    }, new VelocityTemplateEngine());

    get("/development", (request, response) -> {
      HashMap<String, Object> model = new HashMap<String, Object>();
      model.put("template", "templates/development.vtl");
      return new ModelAndView(model,layout);
    }, new VelocityTemplateEngine());

    get("/download", (request, response) -> {
      HashMap<String, Object> model = new HashMap<String, Object>();
      model.put("template", "templates/download.vtl");
      return new ModelAndView(model,layout);
    }, new VelocityTemplateEngine());

  }
}
