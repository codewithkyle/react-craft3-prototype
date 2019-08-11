import { Component } from "react";

import { Courses } from './Courses';

interface Course{
	title : string;
	description : string;
	category : string;
	duration : string;
	points : string;
	id : string;
}

export class CourseCard extends Component
{
	private _course : Course;
	private _view : HTMLElement|null;

	constructor(course:Course, index:number, props:any = null)
	{
		super(props);
		this._course = course;
		this._view = document.body.querySelector(`main article .shell section #card-${ CSS.escape(index.toString()) }`);
		this.displayCard();
	}

	private handlePurchaseClick:EventListener = this.purchaseCourse.bind(this);

	private purchaseCourse()
	{
		const token = sessionStorage.getItem('token');

		if (!token)
		{
			return;
		}

		const data = new FormData();
		data.append('token', token);
		data.append('courseId', this._course.id);

		fetch('http://react-craft.local/actions/prototype/v1/purchase-course',
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
				new Courses();
			}
		})
		.catch(error => {
			console.error('Failed to get users purchased courses', error);
		});
	}

	private displayCard()
	{
		if (!this._view)
		{
			return;
		}

		const courseName = this._view.querySelector('h1');
		const courseDuration = this._view.querySelector('h2');
		const coursePoints = this._view.querySelector('h3');
		const courseDescription = this._view.querySelector('p');
		const purchaseButton = this._view.querySelector('button');

		if (courseName)
		{
			courseName.innerText = this._course.title;
		}

		if (courseDuration)
		{
			courseDuration.innerText = this._course.duration;
		}

		if (coursePoints)
		{
			coursePoints.innerText = `${ this._course.points } pts`;
		}

		if (courseDescription)
		{
			courseDescription.innerText = this._course.description;
		}

		if (purchaseButton)
		{
			purchaseButton.addEventListener('click', this.handlePurchaseClick);
		}
	}
}
