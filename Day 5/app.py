from django.apps import AppConfig


class AppConfig(AppConfig):
    app = 'app'

    @app.route("/")
    def hello():
        return "Hello, Terraform!"

    if __name__ == "__main__":
        app.run(host="0.0.0.0", port=80)
