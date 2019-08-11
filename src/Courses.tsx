import React, { Component } from "react";
import { render } from "react-dom";

import './courses.scss';

import { CoursesGrid } from './CoursesGrid';

export class Courses extends Component
{
	private _courses:any;

	constructor(props:any = null)
	{
		super(props);
		this._courses = [];
		this.getCourses();
	}

	private getCourses()
	{
		const token = sessionStorage.getItem('token');

		if (!token)
		{
			return;
		}

		console.log('Hello');

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
				this._courses = response.courses;

				const section = document.body.querySelector('main article section');
				if (section)
				{
					if (!this._courses.length)
					{
						section.classList.add('is-empty');
						section.innerHTML = '>_<';
					}
					else
					{
						section.classList.remove('card-grid');
						section.innerHTML = '';
					}
				}
			}

			const view = document.body.querySelector('main article');
			if (view)
			{
				view.classList.add('courses');
				render(<Courses />, view);
			}
		})
		.catch(error => {
			console.error('Failed to get users purchased courses', error);
		});
	}

	private handleAddCourseButtonClick:EventListener = this.showAllCoursesGrid;

	private showAllCoursesGrid()
	{
		const section = document.body.querySelector('main article section');
		if (section)
		{
			new CoursesGrid();
		}
	}

	componentDidMount()
	{
		const courseCount = document.body.querySelector('main article h2');
		if (courseCount)
		{
			courseCount.innerHTML = `${ this._courses.length } ${ (this._courses.length === 1) ? 'Course' : 'Courses' }`
		}

		const addACourseButton = document.body.querySelector('main article .shell #add-course');
		if (addACourseButton)
		{
			addACourseButton.addEventListener('click', this.handleAddCourseButtonClick);
		}
	}
	
	render()
	{
		return(
			<div className="shell">
				<header>
					<div>
						<h1>All Courses</h1>
						<h2></h2>
					</div>
					<div>
						<input type="checkbox" id="filter-type" />
						<label htmlFor="filter-type">
							<div>
								<svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="list-ul" className="svg-inline--fa fa-list-ul fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M48 368a48 48 0 1 0 48 48 48 48 0 0 0-48-48zm0-160a48 48 0 1 0 48 48 48 48 0 0 0-48-48zm0-160a48 48 0 1 0 48 48 48 48 0 0 0-48-48zm448 24H176a16 16 0 0 0-16 16v16a16 16 0 0 0 16 16h320a16 16 0 0 0 16-16V88a16 16 0 0 0-16-16zm0 160H176a16 16 0 0 0-16 16v16a16 16 0 0 0 16 16h320a16 16 0 0 0 16-16v-16a16 16 0 0 0-16-16zm0 160H176a16 16 0 0 0-16 16v16a16 16 0 0 0 16 16h320a16 16 0 0 0 16-16v-16a16 16 0 0 0-16-16z"></path></svg>
							</div>
							<div>
								<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="th-large" className="svg-inline--fa fa-th-large fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M296 32h192c13.255 0 24 10.745 24 24v160c0 13.255-10.745 24-24 24H296c-13.255 0-24-10.745-24-24V56c0-13.255 10.745-24 24-24zm-80 0H24C10.745 32 0 42.745 0 56v160c0 13.255 10.745 24 24 24h192c13.255 0 24-10.745 24-24V56c0-13.255-10.745-24-24-24zM0 296v160c0 13.255 10.745 24 24 24h192c13.255 0 24-10.745 24-24V296c0-13.255-10.745-24-24-24H24c-13.255 0-24 10.745-24 24zm296 184h192c13.255 0 24-10.745 24-24V296c0-13.255-10.745-24-24-24H296c-13.255 0-24 10.745-24 24v160c0 13.255 10.745 24 24 24z"></path></svg>
							</div>
						</label>
						<button id="search">
							<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="search" className="svg-inline--fa fa-search fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z"></path></svg>
						</button>
						<button id="add-course">
							<svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="plus" className="svg-inline--fa fa-plus fa-w-12" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><path fill="currentColor" d="M368 224H224V80c0-8.84-7.16-16-16-16h-32c-8.84 0-16 7.16-16 16v144H16c-8.84 0-16 7.16-16 16v32c0 8.84 7.16 16 16 16h144v144c0 8.84 7.16 16 16 16h32c8.84 0 16-7.16 16-16V288h144c8.84 0 16-7.16 16-16v-32c0-8.84-7.16-16-16-16z"></path></svg>
							Add a Course
						</button>
					</div>
				</header>
				<section></section>
			</div>
		);
	}
}
