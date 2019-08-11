import React, { Component } from "react";
import { render } from "react-dom";

import './courses.scss';

interface Course{
	title : string;
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
			for (let i = 0; i < this._courses.length; i++)
			{
				view.innerHTML += `${ this._courses[i].title }<br>`;
			}
		}
	}
}
