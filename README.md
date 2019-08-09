# React + Craft 3 Prototype

The goal of this project is to quickly prototype what a React app would look like with content served from Craft CMS.

### Running the prototype

1. Clone this repo and enter the base project directory with your terminal
2. Install node modules

```script
npm ci
```

3. Install vendor files

```script
cd ./craftcms && composer install
```

4. Point an apache web server to `craftcms/public`
5. Create an new empty database
6. Import the database file from `craftcms/`
7. Clone the `.env.example` file

```script
mv ./.env.example ./.env
```

8. Open the new `.env` file and enter you local environment information
9. Navigate to your web server in a browser
10. Install Craft CMS
11. Build the React app

```script
cd .. && npm run build && npm run preview
```