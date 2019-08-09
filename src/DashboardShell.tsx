import React, { Component } from "react";
import { render } from "react-dom";

export class DashboardShell extends Component
{
	constructor(props:any = null)
	{
		super(props);
		render(<DashboardShell />, document.body);
	}

	render()
	{
		return(
			<main className="t-dashboard">
				<aside></aside>
				<section></section>
			</main>
		);
	}
}
