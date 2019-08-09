import React, { Component } from "react";
import { render } from "react-dom";

export class LoginForm extends React.Component
{
	private _loginForm : HTMLFormElement|null;
	private _root : HTMLElement;

	constructor(props:any)
	{
		super(props);
		this._loginForm = null;
		this._root = (document.body.querySelector('main') || document.body);
		render(<LoginForm />, this._root);
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
	}

	render()
	{
		return (
			<div className="t-login">
				<form className="is-hidden">
					<input type="email" name="email" placeholder="Email" />
					<input type="password" name="password" placeholder="Password" />
					<button type="submit">Log In</button>
				</form>
			</div>
		);
	}
}
