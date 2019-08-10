import React, { Component } from "react";

import { Dashboard } from './Dashboard';

export class View extends Component
{
	componentDidMount()
	{
		new Dashboard();
	}

	render()
	{
		return(
			<section></section>
		);
	}
}
