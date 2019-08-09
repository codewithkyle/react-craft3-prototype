import React, { Component } from "react";

import './sidebar.scss';

import { SignoutButton } from './SignoutButton';

export class Sidebar extends Component
{
	render()
	{
		return(
			<aside>
				<div className="user-info">
					<div className="user-info_icon">
						<span>KA</span>
					</div>
					<span className="user-info_name">Kyle Andrews</span>
					<span className="user-info_email">kylea@page.works</span>
				</div>
				<nav>
					<button className="is-active">Dashboard</button>
					<button>Courses</button>
					<button>Wishlist</button>
					<button>Teach</button>
					<button>Settings</button>
				</nav>
				<SignoutButton></SignoutButton>
			</aside>
		);
	}
}
