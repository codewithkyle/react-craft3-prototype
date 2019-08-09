import React, { Component } from "react";
import { render } from "react-dom";

import { LoginForm } from './LoginForm';

export class SignupForm extends React.Component
{

	private _root : HTMLElement;
	private _form : HTMLFormElement|null;

	constructor(props:any = null)
	{
		super(props);

		this._root = (document.body.querySelector('main') || document.body);
		render(<SignupForm />, this._root);

		this._form = null;
	}

	private handleFormSubmit:EventListener = this.submitSignupForm.bind(this);
	private handleLoginClick:EventListener = this.showLoginForm.bind(this);

	private showLoginForm()
	{
		if (this._form && this._form.parentElement)
		{
			this._form.parentElement.style.display = 'none';
			new LoginForm();
		}
	}

	private submitSignupForm(e:Event)
	{
		e.preventDefault();

		if (!this._form)
		{
			return;
		}

		const data = new FormData(this._form);

		fetch('http://react-craft.local/actions/prototype/v1/signup',
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
				else if(response.errors.length)
				{
					for (let i = 0; i < response.errors.length; i++)
					{
						console.error(response.errors[i]);
					}
				}
			})
			.catch(error => {
				console.error('Failed to sign up user', error);
			});
	}

	componentDidMount()
	{
		this._form = this._root.querySelector('.t-signup form');
		
		if (this._form)
		{
			this._form.addEventListener('submit', this.handleFormSubmit);
		}

		const loginButton = this._root.querySelector('.t-signup p button');

		if (loginButton)
		{
			loginButton.addEventListener('click', this.handleLoginClick);
		}
	}

	render()
	{
		return(
			<div className="t-signup">
				<form>
					<input type="text" name="name" placeholder="Full Name" required />
					<input type="email" name="email" placeholder="Email" required />
					<input type="password" name="password" placeholder="Password" required />
					<button type="submit">Sign Up</button>
				</form>
				<p>Already have an account? <button>Log in.</button></p>
			</div>
		);
	}
}
