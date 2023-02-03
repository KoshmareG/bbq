# BBQ

BBQ is an application that helps to organize events. Create your own event and gather people around you or go to someone else's event. Subscribe to the alert and don't miss anything important. Share your photos and impressions in the comments. If you have an event for your own only, you can protect it with a PIN code.

The application was created on Ruby 3.1.2 and Ruby on Rails 7.0.4

### Required to run the application

`Ruby` and `Node` installed. `PostgreSQL` is used for data storage. A `Redis` database is also needed.

Before launching, you need to configure `credentials.yml.enc`. To do this, delete the `config/credentials.yml.enc` file and run the command:

```
$ EDITOR="vim" rails credentials:edit
```

You can use the vim or nano editor

Next, you need to run the following commands:

```
$ bundle
$ rails db:create
$ rails db:migrate
$ yarn build
$ yarn build:css
```

Run app:

```
$ rails s
```

And visit `http://localhost:3000`.

### Additional features

[Yandex API Key](https://yandex.ru/dev/maps/?p=realty) is required for the card to work. Put the key in `config/credentials.yml.enc`:

```
ya_api_key: your Yandex API Key here
```

If you want to be able to log in using [GitHub OAuth](https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps) and [Yandex OAuth](https://yandex.ru/dev/id/doc/dg/oauth/concepts/about.html), you need to connect the application to the appropriate service. Then specify in `config/credentials.yml.enc`:

```
githun_oauth:
  github_key: #Your GitHub application key
  github_secret: #Your GitHub secret key

yandex_oauth:
  yandex_key: #Your Yandex application key
  yandex_secret: #Your Yandex secret key
```

In the production environment, [Yandex Cloud](https://cloud.yandex.ru/) is used to store files. To configure it, add to `config/credentials.yml.enc`:

```
yc:
  access_key_id: #Your Yandex Cloud access key
  secret_access_key: #Your Yandex Cloud secret key
```

### Database in production

In the `production` environment, you must specify the database login and password in the environment variables `DATABASE_USERNAME` and `DATABASE_PASSWORD` or specify explicitly in `config/storage.yml`

```
production:
  <<: *default
  database: bbq_production
  username: #Your database username
  password: #Your database password
```
