import React, { Component } from "react";
import { render } from "react-dom";

import { SignupForm } from './SignupForm';
import { DashboardShell } from './DashboardShell';

export class LoginForm extends React.Component
{
	private _loginForm : HTMLFormElement|null;
	private _root : HTMLElement;

	constructor(props:any = null)
	{
		super(props);
		this._loginForm = null;
		this._root = (document.body.querySelector('main') || document.body);
		render(<LoginForm />, this._root);
	}

	private submitFormEvent:EventListener = this.submitLoginForm.bind(this);
	private handleSignupClick:EventListener = this.showSignupForm.bind(this);

	private showSignupForm()
	{
		
		if (this._loginForm && this._loginForm.parentElement)
		{
			this._loginForm.parentElement.style.display = 'none';
		}

		new SignupForm();
	}

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
					new DashboardShell();
				}
			})
			.catch(error => {
				console.error('Failed to log in user', error);
			});
		}
	}

	componentDidMount()
	{
		this._loginForm = document.body.querySelector('.t-login form');

		if (this._loginForm)
		{
			this._loginForm.addEventListener('submit', this.submitFormEvent);
		}

		const signupButton:HTMLButtonElement|null = document.body.querySelector('.t-login p button');

		if (signupButton)
		{
			signupButton.addEventListener('click', this.handleSignupClick);
		}
	}

	render()
	{
		return (
			<div className="t-login">
				<form>
					<input type="email" name="email" placeholder="Email" required />
					<input type="password" name="password" placeholder="Password" required />
					<button type="submit">Log In</button>
				</form>
				<p>Don't have an account? <button>Sign up.</button></p>
			</div>
		);
	}
}
