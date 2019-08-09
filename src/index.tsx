import * as React from "react";
import { render } from "react-dom";

class CoursesApp extends React.Component
{
	constructor(props:any)
	{
		super(props);

		this.getCsrfToken();
	}

	getCsrfToken()
	{
		fetch('http://react-craft.local/actions/users/get-remaining-session-time',
		{
			method: 'GET',
			headers: new Headers({
			'Accept': 'application/json'
			})
		})
		.then(request => request.json())
		.then(response => {
			document.documentElement.dataset.csrf = response.csrfTokenValue;
			if (response.timeout === 0)
			{
			console.log('show login');
			}
		})
		.catch(error => {
			console.error('Failed to call hello world', error);
		});
	}

	render()
	{
		return (
			<div className="App">
			<h1>Hello world!</h1>
			</div>
		);
	}
}

const rootElement = document.body.querySelector('root-view');
render(<CoursesApp />, rootElement);
