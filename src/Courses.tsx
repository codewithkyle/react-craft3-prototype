import React, { Component } from "react";
import { render } from "react-dom";

export class Courses extends Component
{
	constructor(props:any = null)
	{
		super(props);
		const view = document.body.querySelector('main section');
		render(<Courses />, view);
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
				console.log(response);
			}
		})
		.catch(error => {
			console.error('Failed to get users purchased courses', error);
		});
	}
	
	render()
	{
		return(
			<div>Courses</div>
		);
	}
}
