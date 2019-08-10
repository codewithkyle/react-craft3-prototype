import React, { Component } from "react";
import { render } from "react-dom";

import './courses.scss';

export class Courses extends Component
{
	constructor(props:any = null)
	{
		super(props);
		const view = document.body.querySelector('main section');
		if (view)
		{
			view.classList.add('courses');
			render(<Courses />, view);
		}
	}

	componentDidMount()
	{
		const token = sessionStorage.getItem('token');

		if (!token)
		{
			return;
		}

		const data = new FormData();
		data.append('token', token);

		fetch('http://react-craft.local/actions/prototype/v1/get-user-courses',
		{
			method: 'POST',
			headers: new Headers({
				'Accept': 'application/json',
				'X-Requested-With': 'XMLHttpRequest'
			}),
			body: data
		})
		.then(request => request.json())
		.then(response => {
			if (response.success)
			{
				this.buildCourses(response);
			}
		})
		.catch(error => {
			console.error('Failed to get users purchased courses', error);
		});
	}

	private buildCourses(response:any)
	{
		const courseCount = document.body.querySelector('main section h2');

		if (courseCount)
		{
			courseCount.innerHTML = `${ response.courses.length } ${ (response.courses.length === 1) ? 'Course' : 'Courses' }`
		}
	}
	
	render()
	{
		return(
			<header>
				<div>
					<h1>All Courses</h1>
					<h2></h2>
				</div>
				<div>
					<button>
						<svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="plus" className="svg-inline--fa fa-plus fa-w-12" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><path fill="currentColor" d="M368 224H224V80c0-8.84-7.16-16-16-16h-32c-8.84 0-16 7.16-16 16v144H16c-8.84 0-16 7.16-16 16v32c0 8.84 7.16 16 16 16h144v144c0 8.84 7.16 16 16 16h32c8.84 0 16-7.16 16-16V288h144c8.84 0 16-7.16 16-16v-32c0-8.84-7.16-16-16-16z"></path></svg>
						Add a Course
					</button>
				</div>
			</header>
		);
	}
}
