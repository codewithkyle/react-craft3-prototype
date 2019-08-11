import { Component } from "react";

import './courses.scss';

import { CourseCard } from './CourseCard';

interface Course{
	title : string;
	description : string;
	category : string;
	duration : string;
	points : string;
	id : string;
}

export class CoursesGrid extends Component
{
	private _courses : Array<Course>;

	constructor(props:any = null)
	{
		super(props);

		this._courses = [];
		this.getCourses();
		const view = document.body.querySelector('main article .shell section');
		if (view)
		{
			view.classList.remove('is-empty');
		}
	}

	private getCourses()
	{
		fetch('http://react-craft.local/courses.json',
		{
			method: 'GET',
			headers: new Headers({
				'Accept': 'application/json',
				'X-Requested-With': 'XMLHttpRequest'
			})
		})
		.then(request => request.json())
		.then(response => {
			this._courses = response.data;
			this.displayCourses();
		})
		.catch(error => {
			console.error('Failed to get users purchased courses', error);
		});
	}

	private displayCourses()
	{
		const view = document.body.querySelector('main article .shell section');

		if (view)
		{
			view.innerHTML = '';
			view.classList.add('card-grid');
			for (let i = 0; i < this._courses.length; i++)
			{
				const courseCard = document.createElement('div');
				courseCard.id = `card-${ i }`;
				courseCard.classList.add('course-card');
				courseCard.innerHTML += '<h1></h1>';
				courseCard.innerHTML += '<h2></h2>';
				courseCard.innerHTML += '<h3></h3>';
				courseCard.innerHTML += '<p></p>';
				courseCard.innerHTML += '<button>Purchase</button>';
				view.appendChild(courseCard);
				new CourseCard(this._courses[i], i);
			}
		}
	}
}
