# React + Craft 3 Prototype

The goal of this project is to quickly prototype what a React app would look like with content served from Craft CMS.

## Project Goals

1. See what all the [hoopla's](https://www.youtube.com/watch?v=yICai9wwRl4) about with [React](https://reactjs.org/)
1. Experiment with Crafts [Element API](https://plugins.craftcms.com/element-api) plugin
1. Experiment with capabilities of using Craft as a [headless CMS](https://docs.craftcms.com/v3/dev/headless.html#app)

## Running the Prototype

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
6. Import the `database.sql` file from `craftcms/` directory
7. Clone the `.env.example` file

```script
cp ./.env.example ./.env
```

8. Open the new `.env` file and enter you local environment information
9. Build the React app

```script
cd .. && npm run build && npm run preview
```

10. Sign up for an account, emails are not validated

## Design

<img alt="Yo-sinau Course Dashboard" src="./dribbble_reference.jpg" />

Design created by [Dicky Indrayan](https://dribbble.com/dickyindrayan), checkout the design on [dribbble](https://dribbble.com/shots/6905878-Yo-sinau-Course-Dashboard).

## Postmortem

Before I dive into what I built or provide my opinion of React I'll start by saying that it is entirely possible that I didn't do things "correct". I didn't read/watch anything beyond the [Intro to React](https://reactjs.org/tutorial/tutorial.html) tutorial. It's possible that I got some of the paradigms "incorrect", my prior knowledge is based around my previous experiment with [web components](https://github.com/codewithkyle/web-components-prototype) and based on how easy native web components were I started this project with the assumption that React components would be just as easy/intuitive.

React was interesting to work with and I can see the benefit of using an existing JavaScript framework instead of trying to use something like web components. The initial project setup timesink is minimal and most of the common problems have already been solved and questions answered by the community.

However, there were a few things that I found unintuitive. Shall we get nitpicky? Yes, let's get nitpicky.

I understand why `class` needs to be `className` but what I found frustrating is that when writing a `for` attribute for a `<label>`  is that `forName` didn't work, instead, I eventually found that the correct usage was `htmlFor`. I assume these minor inconsistencies are the side effect of open source development but it would have been nice to if either `className` and `forName` worked or `htmlClass` and `htmlFor` worked. Having to learn and remember these slight inconsistencies is frustrating.

But you know, that's just, like, my opinion, man.


