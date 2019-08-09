import * as React from "react";
import { render } from "react-dom";

class CoursesApp extends React.Component
{
	private _loginForm : HTMLFormElement|null;

	constructor(props:any)
	{
		super(props);
		this._loginForm = null;
	}

	private submitFormEvent:EventListener = this.submitLoginForm.bind(this);

	private submitLoginForm(e:Event)
	{
		e.preventDefault();
		if (this._loginForm)
		{
			const data = new FormData(this._loginForm);

			fetch('http://react-craft.local/actions/prototype/v1/login',
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
					sessionStorage.setItem('token', response.token);
				}
			})
			.catch(error => {
				console.error('Failed to log in user', error);
			});
		}
	}

	componentDidMount()
	{
		this._loginForm = document.body.querySelector('form');

		if (this._loginForm)
		{
			this._loginForm.addEventListener('submit', this.submitFormEvent);
		}

		const sessionToken = sessionStorage.getItem('token');

		if (sessionToken)
		{
			/** TODO: Proceed to dashboard, session is still valid, user refreshed or restored their session */
		}
	}

	render()
	{
		return (
			<div className="t-login">
				<form className="is-hidden">
					<input type="email" name="email" placeholder="Email" />
					<input type="password" name="password" placeholder="Password" />
					<input type="checkbox" name="rememberMe" value="1" />
					<button type="submit">Log In</button>
				</form>
			</div>
		);
	}
}

const rootElement = document.body.querySelector('root-view');
render(<CoursesApp />, rootElement);
