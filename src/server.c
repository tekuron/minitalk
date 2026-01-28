/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: danz <danz@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/16 15:26:15 by danzamor          #+#    #+#             */
/*   Updated: 2025/11/18 19:19:36 by danz             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#define _DEFAULT_SOURCE
#define _POSIX_C_SOURCE 199309L
#include <signal.h>
#include <unistd.h>
#include "libft.h"
#include "ft_printf_bonus.h"
#include "minitalk.h"

void	signal_handler(int signum, siginfo_t *info, void *context)
{
	static unsigned char	c;
	static int				bits_recieved;

	(void)context;
	(void)info;
	if (signum == SIGUSR2)
		c = (c << 1) | 1;
	else if (signum == SIGUSR1)
		c = (c << 1) | 0;
	bits_recieved++;
	if (bits_recieved == 8)
	{
		if (c != 0)
			(void)write(1, &c, 1);
		bits_recieved = 0;
		c = 0;
	}
}

int	main(void)
{
	t_mt				mt;
	struct sigaction	sa;

	mt.server_pid = getpid();
	ft_printf("PID: %d\n", mt.server_pid);
	sigemptyset(&sa.sa_mask);
	sa.sa_sigaction = signal_handler;
	sa.sa_flags = SA_SIGINFO;
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	while (1)
		pause();
}
