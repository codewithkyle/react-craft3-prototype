import React, { Component } from "react";
import { render } from "react-dom";

/** CSS */
import './base.css';

/** Components */
import { LoginForm } from './LoginForm';

class CoursesApp extends Component
{
	constructor(props:any)
	{
		super(props);
	}

	componentDidMount()
	{
		const sessionToken = sessionStorage.getItem('token');

		if (sessionToken)
		{
			/** TODO: Proceed to dashboard, session is still valid, user refreshed or restored their session */
		}
		else
		{
			new LoginForm();
		}
	}

	render()
	{
		return(
			<main></main>
		);
	}
}

const rootElement = document.body;
render(<CoursesApp />, rootElement);
