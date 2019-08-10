import React, { Component } from "react";
import { render } from "react-dom";

export class Dashboard extends Component
{
	constructor(props:any = null)
	{
		super(props);
		const view = document.body.querySelector('main section');
		render(<Dashboard />, view);
	}
	
	render()
	{
		return(
			<div>Dashboard</div>
		);
	}
}