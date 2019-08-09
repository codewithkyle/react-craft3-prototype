import React, { Component } from "react";

export class SignoutButton extends Component
{
	private handleSignoutClick:EventListener = this.signoutUser.bind(this);

	private signoutUser()
	{
		const token = sessionStorage.getItem('token');

		if (!token)
		{
			return;
		}

		console.log('test');

		const data = new FormData();
		data.append('token', token);

		fetch('http://react-craft.local/actions/prototype/v1/logout',
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
				sessionStorage.removeItem('token');
				window.location.href = window.location.origin;
			}
		})
		.catch(error => {
			console.error('Failed to log out the user', error);
		});
	}

	componentDidMount()
	{
		const button = document.body.querySelector('.user-signout');

		if (button)
		{
			button.addEventListener('click', this.handleSignoutClick);
		}
	}

	render()
	{
		return(
			<button className="user-signout">Sign Out</button>
		);
	}
}
